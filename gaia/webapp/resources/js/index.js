/**********************************

	Document Ready 시작

********************************/
$(function() {

	/**********************************
		버튼 매핑 시작
	********************************/
	
	
	let signInArea = $('#signInArea');
	let signUpArea = $('#signUpArea');
	
  	// 로그인 버튼 클릭시 로그인 화면 보여주기. 
	$('#signInBtn').on('click', function(){
		toggleHidden(signInArea);
		signUpArea.prop('hidden', true);
	})
	
   	// 회원가입 클릭시 가입 화면 보여주기. 
	$('#signUpBtn').on('click', function(){
		toggleHidden(signUpArea);
		signInArea.prop('hidden', true);
	})
	
	// 영역 바깥 클릭 이벤트
	$('body').click(function(e) {
		// 영역 바깥쪽이고 가입이나 로그인 버튼이 아닐 경우 폼을 숨긴다.
		if($(e.target).parents('.formArea').length < 1
				&& ! $(e.target).hasClass('formArea')
				&& ! $(e.target).hasClass('btnImg') ){
			signInArea.prop('hidden', true);
			signUpArea.prop('hidden', true);
			
			// 아이디 비번 입력했던것도 지워준다
			$('#username').val('');
			$('#password').val('');
			
		} 
	});
	
	// 관리용 히든 로그인 이벤트
	signInButton = $('#signInArea').find('button');
	 $('#hiddenKkobuk').on('click', function(){
		 idInput.value = 'kkobuk';
		 pwInput.value = 'java';
		 signInButton.click();
	 })
	 $('#hiddenEisen').on('click', function(){
		 idInput.value = 'eisen';
		 pwInput.value = 'java';
		 signInButton.click();
	 })
	 $('#hiddenJosh').on('click', function(){
		 idInput.value = 'josh';
		 pwInput.value = 'java';
		 signInButton.click();
	 })
	 $('#hiddenAdmin').on('click', function(){
		 window.open(getContextPath()+"/admin");
	 })
	 $('#demo').on('click', function(){
	 	event.preventDefault();
	 	$('#hiddenKkobuk').click();
	 });

	$('body').on('click', '#joinBtn', function(){
		event.preventDefault();
		joinFunction();
	})	

	/**********************************
					버튼 매핑 끝
			
		document ready 바인딩 시작
	********************************/
	
	// 비밀번호 재 입력 확인
	$('#signUpPass1').on('input', function(){
		passCheck();
	})
	$('#signUpPass2').on('input', function(){
		passCheck();
	})
	
	 // 중복 아이디 검사
	 $('#signUpId').on('input', function(){
		 
		let inputText = $(this).val().trim();
        let usernameicon = $('#hiddenJosh');
        usernameicon.removeClass();
		
		if(!inputText || inputText.length < 4){
            usernameicon.addClass('icon icon-user');
			return;
		}
		 
        $.ajax({
            "url": getContextPath()+"/signup/idCheck",
            "method": "post",
            "data": { "mem_id": inputText },
            "dataType": "json",
            "success": function (result) {
            	
              
              if (result.result == "OK") {
                // 만들 수 있는 아이디
                usernameicon.addClass('icon icon-check');
              } else {
            	 // 중복된 아이디
                usernameicon.addClass('icon icon-close');
              }
              
            },
            "error": function (xhr) {
              console.log(xhr.status);
            }, async : false
        })
		 
	 })

        // 한글 입력 방지
    	var idInput = document.querySelector('#username');
		var pwInput = document.querySelector('#password');
		var signUpId = document.querySelector('#signUpId');
		var signUpPass1 = document.querySelector('#signUpPass1');
		var signUpPass2 = document.querySelector('#signUpPass2');
		
		var korean = function() {
		  var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		  this.value = this.value.replace(pattern, '');
		};
		
		idInput.addEventListener('keyup', korean);
		pwInput.addEventListener('keyup', korean);
		signUpId.addEventListener('keyup', korean);
		signUpPass1.addEventListener('keyup', korean);
		signUpPass2.addEventListener('keyup', korean);



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
passCheck = function(){
	
	var pass1 = $('#signUpPass1').val();
	var pass2 = $('#signUpPass2').val();
	let passChecker = $('#passChecker');
	
	// pass 1이나 2가 없을 경우 자물쇠 아이콘으로 다시 만들고 함수 종료
	if(!pass1 || !pass2){
		passChecker.removeClass();
		passChecker.addClass('icon icon-lock');
		return;
	}
	
	if(pass1 == pass2){
		passChecker.removeClass();
		passChecker.addClass('icon icon-check');
	}else{
		passChecker.removeClass();
		passChecker.addClass('icon icon-close');
	}
}

joinFunction = function(){
	
	$('#signUpArea').prop('hidden', true);
	
	var form = $('#signupForm')[0];
	var formData = new FormData(form);
	
   $.ajax({
		url : getContextPath() + '/signup/register',
		method : 'post',
		data : formData,
		success : function(res) {
			
			if(res == "OK"){
				// 가입 성공하면 가입 폼들 비워준다.
				$('#signupForm').find('input[type=text]').val('');
				
				Swal.fire(
				  '회원 가입 성공',
				  '로그인 버튼을 눌러 로그인 해 주세요.',
				  'success'
				)
			}else{
				Swal.fire(
				  '가입 실패',
				  '회원 가입에 실패 했습니다. 로그를 확인해주세요.',
				  'error'
				)
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json',
		processData:false,
    	contentType:false,
		cache:false,
		enctype:'multipart/form-data'
	})
	
}







