/**********************************

	Document Ready 시작

********************************/
$(function(){
	
	
	/******************************************************
	*
	*       버튼 매핑 
	*
	 *****************************************************/
	
	
	/******************************************************
	*
	*       이벤트 매핑 
	*
	 *****************************************************/
	$('body').on('click', '.profile', function(){
		let src = $(this).attr('src');
		let user_no = src.substring(src.lastIndexOf('/')+1);
		loadPersonalPage(user_no);
	});
	

	
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
const loadPersonalPage = function(user_no){
	
	// user_no 로 ajax 이용해 user_id 받아온 후 해당 페이지로 이동.
	
	$.ajax({
		url: getContextPath() + '/restapi/member/members/getMemIdFromMemNo.do',
		type: 'get',
		data: {
			'mem_no': user_no
		},
		success: function(mem_id) {
			history.pushState('member-' + 'personalPage', null, getContextPath() + '/' + mem_id);
			memberMovePage('personalPage')
		},
		error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'text'
	})
	
}






