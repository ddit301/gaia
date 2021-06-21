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
		// nonlink 클래스를 가졌을 경우 링크를 태우지 않음.
		if($(this).hasClass('nonlink')){
			return;
		}
		let src = $(this).attr('src');
		let user_no = src.substring(src.lastIndexOf('/')+1);
		// 사진 없어서 액박 떴을 경우 data 에서 받아온다.
		if(user_no == 'default'){
			user_no = $(this).data('mem_no');
		}
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

// 이미지 에러일 경우 default 이미지로 바꿔 주면서, mem_no는 data로 기록하도록 해주는 함수.
const imgOnErr = function(){
	let target = event.target;
	let target_mem_no = target.src.substring(target.src.lastIndexOf('/')+1);
	target.setAttribute('data-mem_no',target_mem_no);
	target.src = getProfilePath();
}




