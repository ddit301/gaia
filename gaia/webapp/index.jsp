<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<!-- saved from url=(0029)http:/www.dadaabstories.org/ -->
<html lang="en" xmlns="http:/www.w3.org/1999/html" class="js no-touch csstransitions wf-cubano-n4-active wf-cubano-i4-active wf-active" style="opacity: 1;">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style class="vjs-styles-defaults">
      .video-js {
        width: 300px;
        height: 150px;
      }
      .vjs-fluid {
        padding-top: 56.25%
      }
    </style>
    
    <title>Gaia</title>
    <meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1">

    <div hidden class="fit-vids-style">­<style>               .fluid-width-video-wrapper {                 width: 100%;                              position: relative;                       padding: 0;                            }                                                                                   .fluid-width-video-wrapper iframe,        .fluid-width-video-wrapper object,        .fluid-width-video-wrapper embed {           position: absolute;                       top: 0;                                   left: 0;                                  width: 100%;                              height: 100%;                          }                                       </style></div>
    <style type="text/css">.tk-cubano{font-family:"cubano",sans-serif;}</style>
	<style type="text/css">
	@font-face {
		font-family: cubano;
		src:
			url(${cPath}/resources/index/l?subset_id=2&fvd=i4&v=3)
			format("woff2"),
			url(${cPath}/resources/index/d?subset_id=2&fvd=i4&v=3)
			format("woff"),
			url(${cPath}/resources/index/a?subset_id=2&fvd=i4&v=3)
			format("opentype");
		font-weight: 400;
		font-style: italic;
		font-display: auto;
	}
	
	@font-face {
		font-family: cubano;
		src:
			url(${cPath}/resources/index/l?subset_id=2&fvd=n4&v=3)
			format("woff2"),
			url(${cPath}/resources/index/d?subset_id=2&fvd=n4&v=3)
			format("woff"),
			url(${cPath}/resources/index/a?subset_id=2&fvd=n4&v=3)
			format("opentype");
		font-weight: 400;
		font-style: normal;
		font-display: auto;
	}
	</style>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
    <link rel="stylesheet" href="${cPath}/resources/index/gridpak.css">
    <link rel="stylesheet" href="${cPath}/resources/index/style.css">
    <link rel="stylesheet" href="${cPath}/resources/index/bigvideo.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.css">
    <script src="${cPath}/resources/index/modernizr-2.6.2.js"></script>
    <script src="${cPath}/resources/index/jquery-1.12.4.min.js"></script>
    <script src="${cPath }/resources/js/util.js"></script>
    
<!-- index script start -->
<script>

	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	  gtag('config', 'UA-190810131-3');
	  
		function getContextPath() {
	   		return "<%=request.getContextPath()%>";
		}
		// 로그인 실패시 처리인데 어쩔수없이 일단 이렇게 짜뒀습니다.
        let authUser = '${sessionScope } ${authUser }'
        let message = null;
        if(authUser.includes('$$$')){
	        message = authUser.substring(authUser.indexOf('$$$')+3);
	        message = message.substring(0,message.indexOf('$$$'));
        }
        
        $(function(){
        	
        	if(message){
        		// 로그인 실패시 로그아웃 처리
        		$.ajax({
					url : getContextPath() + '/signout',
					method : 'get',
					error : function(xhr, error, msg) {
						ajaxError(xhr, error, msg);
					}
				})
        		
        		alert(message);
	        	//화면 위로 올리기 
	        	window.scrollTo(0,0);
        	}
        	
        	let signInArea = $('#signInArea');
        	let SingUpArea = $('#signUpArea');
        	
        	// 로그인 버튼 클릭시 로그인 화면 보여주기. 
        	$('#signInBtn').on('click', function(){
        		toggleHidden(signInArea);
        		SingUpArea.prop('hidden', true);
        	})
        	
        	// 회원가입 클릭시 가입 화면 보여주기. 
        	$('#signUpBtn').on('click', function(){
        		toggleHidden(SingUpArea);
        		signInArea.prop('hidden', true);
        	})
        	
        	// 영역 바깥 클릭 이벤트
        	$('body').click(function(e) {
        		// 영역 바깥쪽이고 가입이나 로그인 버튼이 아닐 경우 폼을 숨긴다.
        		if($(e.target).parents('.formArea').length < 1
        				&& ! $(e.target).hasClass('formArea')
        				&& ! $(e.target).hasClass('btnImg') ){
        			signInArea.prop('hidden', true);
        			SingUpArea.prop('hidden', true);
        			
        			// 아이디 비번 입력했던것도 지워준다
        			$('#username').val('');
        			$('#password').val('');
        			
        		} 
        	});

        	
        	
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
        	
			// 비밀번호 재 입력 확인
			$('#signUpPass1').on('input', function(){
				passCheck();
			})
			$('#signUpPass2').on('input', function(){
				passCheck();
			})
			
			
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
				 window.location.href="${cPath}/admin"
			 })
			
			
        })
        
		
</script>
<!-- index script end -->
</head>
<body style="opacity: 1;">

<div id="categories" class="top-feature slider container">
   
    <div class="video-wrapper" style="height: 882px; left: 0%;">
        <div class="screen intro" id="screen-1" data-video="media/market">
            <video muted="" loop="" src="${cPath}/resources/index/intro.mp4"></video>
            <div>
                <div class="span_4 col clearfix">
                    &nbsp;
                </div>

                <div class="span_4 col clearfix">
                    <h2 class="screen-heading" style="margin-top: 30%;">
                        <span style="font-size:1.5em">Gaia</span><br>
                        <br>Endless Programming<br>
                    </h2>

                    <p class="body">
                        Gaia is how we build a software.
                        <br>It's made of countless commits
                    </p>
                </div>
            </div>
        </div>
    </div>

    <img class="btnImg" id="signUpBtn" src="${cPath}/resources/index/img/Add User.svg">
    <img class="btnImg" id="signInBtn" src="${cPath}/resources/index/img/Login.svg">
    
</div>

<div class="formArea" id="loginform">

	<div id="signInArea" hidden="true">
		<form method="post" action="${cPath}/signin/signinCheck">
			<div id="nameArea">
				<i id="hiddenKkobuk" class="icon icon-user"></i>
				<input id="username" name="mem_id" type="text" placeholder="Username">
			</div>
			<div id="passArea">
				<i id="hiddenEisen" class="icon icon-lock"></i>
				<input id="password" name="mem_pass" type="password" placeholder="Password">
			</div>
			<button>GET STARTED</button>
		</form>
	</div>
	
	<div id="signUpArea" hidden="true">
		<form method="post" action="${cPath}/signup/register">
			<div>
				<i id="hiddenJosh" class="icon icon-user"></i>
				<input id="signUpId" type="text" name="mem_id" placeholder="Username">
			</div>
			<div>
				<i id="hiddenAdmin" class="icon icon-pencil"></i>
				<input id="signUpName" type="text" name="mem_nick" placeholder="Full name">
			</div>
			<div>
				<i class="icon icon-lock"></i>
				<input id="signUpPass1" type="password" name="mem_pass" placeholder="Password">
			</div>
			<div>
				<i id="passChecker" class="icon icon-lock"></i>
				<input id="signUpPass2" type="password" name="re_pass" placeholder="Re-Enter Password">
			</div>
			<button>JOIN GAIA</button>
		</form>
	</div>
	
</div>



<script src="${cPath}/resources/index/jquery.imagesloaded.min.js"></script>
<script src="${cPath}/resources/index/main.js"></script>
<!-- endbuild -->


</body></html>