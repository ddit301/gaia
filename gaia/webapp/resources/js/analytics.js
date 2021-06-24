/**********************************

	Document Ready 시작

********************************/

$(function() {

	/**********************************
		버튼 매핑 시작
	********************************/



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

// 페이지에 필요한 데이터들 비동기로 받아오기.
const loadAnalytics = function(){
	$.ajax({
		url : getContextPath() + '/',
		method : 'get',
		success : function(res) {
			$.each(res, function(i, v) {
				
			})
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
}

const loadMemberStatics = function(){
	
}










