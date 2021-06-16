<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <div class="main">
        <section class="module bg-dark-30" data-background="resources/main/images/section-4.jpg">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h1 class="module-title font-alt mb-0">Login-Register</h1>
              </div>
            </div>
          </div>
        </section>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3 mb-sm-40">
                <h4 class="font-alt">Register</h4>
                <hr class="divider-w mb-10">
                <form class="form" method="post" action="${pageContext.request.contextPath }/signup/register">
                  <div class="form-group">
                    <input class="form-control" id="E-mail" type="text" name="mem_id" placeholder="ID"/>
                    <span class="checker"></span>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="username" type="text" name="mem_nick" placeholder="Username"/>
                    <span class="checker"></span>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="password" type="password" name="mem_pass" placeholder="Password"/>
                    <span class="checker"></span>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="re-password" type="password" name="re_pass" placeholder="Re-enter Password"/>
                    <span class="checker"></span>
                  </div>
                  <div class="form-group">
                    <button type="submit" class="btn btn-block btn-round btn-b">Register</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
       </div>
  <script>
  
  let pwc=false;
  $("#password").on("keyup", function () {
    let pwvalue = $(this).val().trim();
    const regpw = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*()]).{8,16}$/;
    console.log('a');
    if (pwvalue.trim().length < 8 || pwvalue.trim().length > 16) {
    	console.log('1');
      pwc=nopro(this, "비밀번호는 8~16자 입니다.");
    } else if (!regpw.test(pwvalue)) {
    	console.log('2');
      pwc=nopro(this, "8~16자의 영문 대 소문자, 숫자, 특수문자를 사용하세요.")
    } else {
    	console.log('3');
      pwc=okpro(this);
    }
  })
  
  let pwdc=false;
  $("#re-password").on("keyup", function () {
    let pwvalue = $(this).parents().find("#password").val().trim();
    let pwdcvalue = $(this).val().trim();

    if (pwvalue === pwdcvalue) {
      pwdc=okpro(this);
    } else {
      pwdc=nopro(this, "비밀번호가 일치하지 않습니다.");
    }
  })
  
  let nmc=false;
  $("#username").on("keyup", function () {
    let namevalue = $("#username").val().trim();
    const regname = /^[가-힣]{2,5}$/;

    if (namevalue.length < 2 || namevalue.length > 5) {
      nmc=nopro(this, "이름은 2~5자 사이입니다.");
    } else if (!regname.test(namevalue)) {
      nmc=nopro(this, "이름은 한글만 사용할 수 있습니다.")
    } else {
      nmc=okpro(this);
    }
  })
  
  let alic=false;
  $('#E-mail').on('keyup', function () {

	const input = this;
    let alivalue = $('#E-mail').val().trim();

    if (alivalue.length < 2 || alivalue.length > 15) {
      alic=nopro(this, "아이디는 2~15자 입니다.");
    } else {
    $.ajax({
		"url" : "${cPath}/signup/idCheck",
		"method": "post",
		"data" : {"mem_id" : alivalue},
		"dataType" : "json",
		"success" : function(result){
			console.log(result);
			console.log(result.result)
			if(result.result=="OK"){
				alic=okpro(input);
			}else{
				alic=nopro(input, "중복된 별명입니다.");
			}
		},
		"error" : function(xhr){
			alert("오류 : " + xhr.status);
		}
	})
    }
  })
  
  function okpro(vinput) {
	  let msg = $(vinput).parents(".form-group").find('.checker');
	  $(msg).empty().removeClass('');
	  $(vinput).parents(".form-group").find('.form-control').removeClass('warning-input').addClass('confirm-input');
	  let time = new Date().getTime();
	  $('<i class="fa fa-check"></i>').appendTo(msg).addClass('confirm-icon');
  }
  
  function nopro(vinput, text) {
  $(vinput).parents(".form-group").find('.form-control').removeClass('confirm-input');
  $(vinput).parents(".form-group").find('.form-control').addClass('warning-input');
  $(vinput).parents(".form-group").find('.checker').html(text).addClass('warning-text');
  return false;
}
  </script>