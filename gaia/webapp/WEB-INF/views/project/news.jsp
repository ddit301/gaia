<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="${cPath }/resources/assets/css/news.css" rel="stylesheet">
    
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>

            <div class="container-fluid">
            	<div id="newsmenu" class="row">
            		<div class="col-md-10">
            		</div>
            		<div class="col-md-2">
	            		<button type="button" class="btn mb-1 btn-rounded btn-outline-dark" data-toggle="modal" data-target="#exampleModal">뉴스추가</button>
            		</div>
            	</div>
            	<div id="newsContainer">
            	</div>
            </div>
            
            
뉴스 작성 Modal
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">뉴스 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="news-title-input" class="col-form-label">뉴스 제목</label>
            <input type="text" class="form-control" id="news-title-input">
          </div>
          <div id="editorArea" class="form-group">
            <label class="col-form-label">뉴스 내용</label>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
        <button id="saveNewsBtn" type="button" class="btn btn-success" disabled>Save</button>
      </div>
    </div>
  </div>
</div>
<div id="editor"></div>

<div id="news-template" hidden="hidden" >

	<!-- news template start -->
	 	<div class="news">
       		<div class="newsheader row">
       			<div class="newsWriter col-md-2">
       				<img src="/gaia/resources/assets/images/user/1.png" alt="">
       				<span></span>
       			</div>
       			<div class="newsTitle col-md-6">
       				<p></p> 
       			</div>
       			<div class="newsTime col-md-3">
       				<span></span>
       			</div>
       			<div class="col-md-1">
       				<i class="icon-options menu-icon"></i>
       			</div>
       		</div>
       		<div class="newsBody row">
       			<div class="news-left col-md-6">
       				<img src="/gaia/resources/assets/images/big/about-2.png" alt="">
       			</div>
       			<div class="news-right col-md-6">

       				<div class="newsReplyArea">
       				</div>
      					<div class="news-writebox row">
      						<div class="col-md-10">
      							<input type="text">
      						</div>
      						<div class="col-md-2">
      							<button class="news-rep-reg btn" type="button" class="btn">등록</button>
      						</div>
      					</div>
       			</div>
       		</div>
       	</div>
	<!-- news template end -->
	
	<!-- 	newsContent template -->
	<div id="contTemplate">
		<div class="newsContent">
		</div>
	</div>

	<!-- news reply template start-->
	<div class="news-reply row">
		<div class="col-md-2">
			<div class="repwriter row">
				<img src="/gaia/resources/assets/images/user/1.png" alt="">
			</div>
			<span>Josh</span>
		</div>
		<div class="repcont col-md-10">
			<p></p>
		</div>
	</div>
	<!-- news reply template end-->
	
</div>

 <script>
	currentPage = 1;
 
 	// toastUI 설정 초기화
	 editor = new toastui.Editor({
		  el: document.querySelector('#editor'),
		  height: '400px',
		  initialEditType: 'markdown',
		  previewStyle: 'tab',
		  placeholder : 'markdown 문법을 지원합니다'
	});
	 
	viewer = toastui.Editor.factory({
         el: document.querySelector('.newsContent')
         ,height : 'auto'
         ,viewer : true
       });
	
	 // 에디터를 modal 안에서 생성했더니 에러가 발생해서 modal 밖에서 생성 후 modal 에 넣어줍니다.
	$('#editor').appendTo('#editorArea');
	
	loadNews = function(currentPage){
		$.ajax({
			url : getContextPath() + '/restapi/project/news',
			type : 'get',
			data : {
				'currentPage' : currentPage
			},
			success : function(res) {
				$.each(res, function(i,v){
					let news = getNewsObectWithJson(v);
					$('#newsContainer').append(news);
				})
			},
			error : function(xhr, error, msg) {
				console.log(xhr);
				console.log(error);
				console.log(msg);
			},
			dataType : 'json'
		})
	}
	
	//스크롤 바닥 감지 무한스크롤 코드 
	window.onscroll = function(e) {
	    //window height + window scrollY 값이 document height보다 클 경우,
	    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
	    	//실행할 로직 (콘텐츠 추가)
	        currentPage = currentPage + 1;
	        loadNews(currentPage);
	    }
	};
	

           	
	
	// 페이지 로드시 일단 뉴스 1페이지 로드
	loadNews(1);
	
 	///////////////////////////////////////////////////////////////
 	//////////								///////////////////////
 	//////////		on ready functions 		///////////////////////
 	//////////								///////////////////////
 	///////////////////////////////////////////////////////////////
	$(function(){
		
		$('#saveNewsBtn').on('click', function(){
			news_title = $('#news-title-input').val();
			news_content = editor.getMarkdown();
			// 뉴스 insert 하기
			$.ajax({
				url : getContextPath()+'/restapi/project/news',
				method : 'post',
				data : {
					'news_title' : news_title
					,'news_cont' : news_content
				},
				success : function(res) {
					// toastr 알람
					toastr.success('새로운 뉴스 등록에 성공했습니다.')
					
					// 에디터 비우기
					$('#news-title-input').val('');
					editor.reset();
					// 모달 닫기
					$('#exampleModal').modal('hide')
					
					// 비동기로 새로운 뉴스 생성해 위에 붙여주기
					let news = getNewsObectWithJson(res.news);
					$('#newsContainer').prepend(news);
					
				},
				error : function(xhr, error, msg) {
					console.log(xhr);
					console.log(error);
					console.log(msg);
					if(xhr.status == 401){
						toastr.error("세션이 만료되어 로그인 페이지로 이동합니다.");
						setTimeout(function(){
							window.location.href=getContextPath()
							}, 2000);
					}
					
				},
				dataType : 'json'
			})
			
		})
		
		
		// title과 editor의 내용이 있을 때만 save 버튼 활성화
		editor.on('change', function(){
			checkValidation();
		});
		$('#news-title-input').on('input', function(){
			checkValidation();
		});
		
		// 뉴스 댓글 등록 이벤트
		$('#newsContainer').on('click', '.news-rep-reg', function(){
			let selectedNews = $(this).parents('.news');
			let news_sid = selectedNews.data('news_sid');
			let news_com_cont =  selectedNews.find('.news-writebox').find('input').val();
			// 댓글 내용이 없으면 댓글 등록이 되지 않는다.
			if(news_com_cont.length == 0){
				toastr.error('댓글 내용을 입력해주세요.');
				return false;
			}
			$.ajax({
				url : getContextPath() + '/restapi/project/news-comments',
				method : 'post',
				data : {
					'news_sid' : news_sid
					,'news_com_cont' : news_com_cont
				},
				success : function(res) {
					// toastr 알람
					toastr.success('새로운 댓글 등록에 성공했습니다.')
					
					let comm = getNewsCommentObjectWithJson(res.newsComment);
					selectedNews.find('.newsReplyArea').append(comm);
					selectedNews.find('.news-writebox').find('input').val('');
				},
				error : function(xhr, error, msg) {
					console.log(xhr);
					console.log(error);
					console.log(msg);
					if (xhr.status == 401) {
						toastr.error("세션이 만료되어 로그인 페이지로 이동합니다.");
						setTimeout(function() {
							window.location.href = getContextPath()
						}, 2000);
					}

				},
				dataType : 'json'
			})
		});
		
		
		
	})

// 뉴스 글 작성할때 제목, 내용 둘다 있는지 확인	
var checkValidation = function(){
	let titleLength = $('#news-title-input').val().length;
	let contLength = editor.getMarkdown().length;
	if( titleLength * contLength > 0 ){
		$('#saveNewsBtn').prop('disabled', false);
	}else{
		$('#saveNewsBtn').prop('disabled', true);
	}
}	

// 뉴스 불러올때와 뉴스 새로 작성했을때 화면에 뉴스 객체 렌더링 용
var getNewsObectWithJson = function(v){
	let news = $('#news-template').children('.news').clone();
	
	news.find('.newsTitle').children('p').text(v.news_title);
	// 새로 작성한 글에는 v.writer 가 없습니다. 쿠키에서 접속자의 프로젝트 닉네임 정보를 받아와 기록해야 합니다.
	if(v.writer){
		news.find('.newsWriter').children('span').text(v.writer.mem_nick);
	}else{
		news.find('.newsWriter').children('span').text('쿠키에서 닉네임 받아오기');
	}
	news.find('.newsTime').children('span').text(moment(v.news_write_date == null ? new Date() : v.news_write_date).fromNow());
	news.attr('data-news_sid',v.news_sid);
	
	viewer.setMarkdown(v.news_cont);
	let newsContent = $('#contTemplate').children('div').clone();
	
	if(v.atch_file_sid!=null){
		news.find('.news-right').prepend(newsContent);
	}else{
		news.find('.news-left').html(newsContent);
	}
	
	$.each(v.commentList, function(j, comm){
		let newsComm = getNewsCommentObjectWithJson(comm);
		news.find('.newsReplyArea').append(newsComm);
	})
	
	return news;
}
// 뉴스 댓글 렌더링 하는 함수도 따로 만들어서 재활용 가능하게끔 
var getNewsCommentObjectWithJson = function(comm){
	let newsComm = $('#news-template').children('.news-reply').clone();
	newsComm.children('.repcont').children('p').text(comm.news_com_cont);
	newsComm.attr('data-com_no',comm.news_com_no);
	// 댓글 불러오는게 아닌 새로운 댓글 작성시에는 commentWriter 가 비어있다. 
	if(comm.commentWriter){
		newsComm.find('span').text(comm.commentWriter.mem_nick);
	}else{
		newsComm.find('span').text('작성자 쿠키에서 받아오세요');
	}
	return newsComm;
}
				
 </script>
            
            
            
            
            
            
            
            