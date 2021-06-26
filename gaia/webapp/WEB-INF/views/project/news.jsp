<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="container-fluid">
	<div id="newsmenu" class="row">
		<div class="col-md-12">
	 		<button type="button" class="btn mb-1 btn-rounded btn-outline-dark" data-toggle="modal" data-target="#exampleModal">뉴스추가</button>
		</div>
	</div>
	<div id="newsContainer">
	</div>
</div>

<!-- <div id="top" style="display: hidden;"> -->
<div id="top" hidden="true" >
	<i class="icon-arrow-up-circle"></i>
</div>

<!-- 뉴스 작성 Modal -->
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
      	<form id="newsImage">
	      	<input type="file" name="file" accept="image/*">
      	</form>
        <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
        <button id="saveNewsBtn" type="button" class="btn btn-success" disabled>Save</button>
      </div>
    </div>
  </div>
</div>

<!-- 마크다운 에디터 -> 에디터로 만들어서 모달로 들어감. -->
<div id="editor"></div>


<!-- 뉴스 관련 템플릿들  -->
<div id="news-template" hidden="hidden" >
 
 <!-- 	newscard 시작 -->
	<div class="news card">
		<div class="newsheader row">
			<div class="mem-overview-card col-md-3">
				<img class="profile" onerror="imgOnErr()" src="/resources/images/profiles/4">
				<span>팀장 꼬북</span>
			</div>
			<div class="newstitle col-md-8">
				<span class="news-title-text">뉴스 제목이 들어갈 자리입니다.</span>
				<span class="newsWriteTime">3 hours ago</span>
			</div>
		</div>
		<div class="newsBody row">
			<div class="news-left col-md-6">
				<a class="lightbox" data-toggle="lightbox">
					<img>
				</a>
			</div>
			<div class="news-right col-md-6">
				<div class="newsReplyArea">
				</div>
				<div class="news-writebox row">
					<div class="col-md-11 row">
						<div class="col-md-3">
							<img class="nonlink profile" src="/resources/images/profiles/2" onerror="imgOnErr()">
						</div>
						<input class="col-md-9" type="text">
					</div>
					<button class="news-rep-reg btn btn-success">등록</button>
    			</div>
			</div>
		</div>
	</div>
<!-- 	newscard 끝 -->
	
	<!-- 	newsContent template -->
	<div id="contTemplate">
		<div class="newsContent">
		</div>
	</div>

	<!-- 					news reply 시작 -->
	<div class="news-reply row">
		<div class="col-md-3">
			<img class="profile" src="/resources/images/profiles/4" onerror="imgOnErr()">
			<p>팀장 꼬북</p>
		</div>
		<div class="col-md-6">
			<span>댓글 내용</span>
		</div>
		<div class="col-md-3">
			<span class="news-rep-time"></span>
		</div>
	</div>
<!-- 					news reply 끝 -->
	
</div>


 <script>
 
	// 페이지 초기화
	currentPage = 1;
	totalPage = null;
 	
	//스크롤 바닥 감지 무한스크롤 코드 
	window.onscroll = function(e) {
		
		let currUrl = window.location.href;
		//news 페이지가 아니면 동작하지 않게끔 한다.
		if(currUrl.substring(currUrl.lastIndexOf('/')+1) != 'news') 
			return false;
		
		// 스크롤이 내려왔을때는 위로 올라가는 버튼 보여준다. 
		if(window.innerHeight < window.scrollY){
			$('#top').attr('hidden', false);
		}else{
			$('#top').attr('hidden', true);
		}
		
	    //window height + window scrollY 값이 document height보다 클 경우,
	    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
			
	    	if(currentPage < totalPage ){
		    	//실행할 로직 (콘텐츠 추가)
		        currentPage = currentPage + 1;
		        loadNews(currentPage);
	    	}
	    }
	};
	
 	///////////////////////////////////////////////////////////////
 	//////////		on ready functions 		///////////////////////
 	///////////////////////////////////////////////////////////////
	$(function(){
		
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
		
		// 페이지 로드시 일단 뉴스 1페이지 로드
		loadNews(currentPage);

		// title과 editor의 내용이 있을 때만 save 버튼 활성화
		editor.on('change', function(){
			checkNewsValidation();
		});

	})
				
 </script>
            
            
            
            
            
            
            
            