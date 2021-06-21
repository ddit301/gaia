/**********************************

	Document Ready 시작

********************************/
$(function() {
	
	/**********************************
		버튼 매핑
	********************************/
	
	// 뉴스 댓글 등록 이벤트
	$('body').on('click', '#newsContainer .news-rep-reg', function(){
		let selectedNews = $(this).parents('.news');
		saveNewsComment(selectedNews);
	});
	
	// 뉴스 등록 버튼 이벤트
	$('body').on('click', '#saveNewsBtn', function(){
		saveNews();
	})
	
	// 뉴스 제목이랑 글 작성에 따른 validation 이벤트
	$('body').on('input', '#news-title-input', function(){
		checkNewsValidation();
	});
	
	// 위로가는 버튼 클릭 이벤트
	$('body').on('click', '#top', function(){
		window.scrollTo({top:0, left:0, behavior:'smooth'});
	})


})
/**********************************

			Document Ready 끝

********************************/



/**********************************
	변수 선언부
********************************/



/**********************************
	함수 선언부
********************************/

// 뉴스 json 데이터로 부터 하나의 뉴스 jquery 객체를 만들어 반환해주는 함수
const getNewsBoxFromJson = function(news){
	let newsBox = $('#news-template').children('.news').clone();
	
	// 뉴스 제목 입력
	newsBox.find('.news-title-text').text(news.news_title);
	
	// 새로 작성한 글에는 news.writer 가 없습니다. 쿠키에서 접속자의 프로젝트 닉네임 정보를 받아와 기록해야 합니다. 프로필 사진 이름도 쿠키에서 받아옵니다.
	if(!news.writer){
		news.writer = {
			mem_nick : getProjNickFromCookie()
			,mem_pic_file_name : getCookie('mem_pic_file_name')
		};
	}
	
	// 작성자 이름 , 사진 등록
	newsBox.find('.mem-overview-card').find('span').text(news.writer.mem_nick);
	newsBox.find('.mem-overview-card').find('img').attr('src', getProfilePath(news.writer.mem_pic_file_name) );
	
	// 작성 시간 등록
	newsBox.find('.newsWriteTime').text(moment(news.news_write_date == null ? new Date() : news.news_write_date).fromNow());
	newsBox.attr('data-news_sid',news.news_sid);
	
	// viewer에 글자 넣고, newsContent로 클론해오기.
	viewer.setMarkdown(news.news_cont);
	let newsContent = $('#contTemplate').children('div').clone();
	
	// 사진이 있을경우와 없을 경우에 따라 다르게 넣어준다.
	if(news.atch_file_sid!=null){
		newsBox.find('.newsReplyArea').prepend(newsContent);
		newsBox.find('.news-left').find('img').attr('src', getNewsPath(news.atch_file_sid));
	}else{
		newsBox.find('.news-left').html(newsContent);
	}
	
	// 댓글들을 모두 렌더링 해서 받아온다.
	$.each(news.commentList, function(j, comm){
		let newsComm = getNewsCommentBoxFromJson(comm);
		newsBox.find('.newsReplyArea').append(newsComm);
	})
	
	return newsBox;
}

// 뉴스 댓글 json 데이터로부터 뉴스 댓글 jquery 객체를 만들어 반환해주는 함수.
const getNewsCommentBoxFromJson = function(comm){
	
	let newsCommentBox = $('#news-template').children('.news-reply').clone();
	newsCommentBox.attr('data-com_no',comm.news_com_no);
	
	// 뉴스 댓글 내용 입력
	newsCommentBox.find('span').text(comm.news_com_cont);
	
	// 댓글 불러오는게 아닌 새로운 댓글 작성시에는 commentWriter 가 비어있다. 
	if(!comm.commentWriter){
		comm.commentWriter = {
			mem_nick : proj_user_nick
			,mem_pic_file_name : mem_pic_file_name
		}
	}
	
	newsCommentBox.find('p').text(comm.commentWriter.mem_nick);
	newsCommentBox.find('img').attr('src', getProfilePath(comm.commentWriter.mem_pic_file_name) );
	
	
	return newsCommentBox;
}


// news 불러와 화면에 출력하는 함수
const loadNews = function(currentPage){
	$.ajax({
		url : getContextPath() + '/restapi/project/news',
		type : 'get',
		data : {
			'currentPage' : currentPage
		},
		success : function(res) {
			// 뉴스가 총 몇페이지까지 만들어지는지 저장해둔다. 해당 변수는 다른 함수에서 사용함.
			totalPage = res.totalPage;
			
			$.each(res.dataList, function(i,news){
				let newsBox = getNewsBoxFromJson(news);
				$('#newsContainer').append(newsBox);
			})
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
}

// 뉴스 저장하는 함수
const saveNews = function(){
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
			let news = getNewsBoxFromJson(res.news);
			$('#newsContainer').prepend(news);
			
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
}

// 뉴스에 댓글 등록 이벤트
const saveNewsComment = function(selectedNews){
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
			let comm = getNewsCommentBoxFromJson(res.newsComment);
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
}

// 뉴스 글 작성할때 제목, 내용 둘다 있는지 확인하는 함수
const checkNewsValidation = function(){
	let titleLength = $('#news-title-input').val().length;
	let contLength = editor.getMarkdown().length;
	if( titleLength * contLength > 0 ){
		$('#saveNewsBtn').prop('disabled', false);
	}else{
		$('#saveNewsBtn').prop('disabled', true);
	}
}	





