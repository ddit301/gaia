<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <div class="main">
    <section class="module bg-dark-30" data-background="resources/main/images/section-4.jpg">
      <div class="container">
        <div class="row">
          <div class="col-sm-6 col-sm-offset-3">
            <h1 class="module-title font-alt mb-0">Login</h1>
          </div>
        </div>
      </div>
    </section>
    <section class="module">
      <div class="container">
        <div class="row">
          <div class="col-sm-6 col-sm-offset-3 mb-sm-40">
            <h4 class="font-alt">Sign in</h4>
            <hr class="divider-w mb-10">
            <form class="form" method="post" action="${pageContext.request.contextPath }/signin/signinCheck">
              <div class="form-group">
                <input class="form-control" id="username" type="text" name="mem_id" placeholder="Username" />
              </div>
              <div class="form-group">
                <input class="form-control" id="password" type="password" name="mem_pass" placeholder="Password" />
                <br />
                <button id="loginSubmit" class="btn btn-block btn-round btn-b" type="submit">Login</button>
                <button data-id="josh" class="testMemBtn btn btn-block btn-round btn-b">JOSH 로그인</button>
                <button data-id="robin" class="testMemBtn btn btn-block btn-round btn-b">ROBIN 로그인</button>
                <button data-id="eisen" class="testMemBtn btn btn-block btn-round btn-b">EISEN 로그인</button>
                <button data-id="kkobuk" class="testMemBtn btn btn-block btn-round btn-b">SHANE 로그인</button>
                <button class="testAdminBtn btn btn-block btn-round btn-b">TEST ADMIN 로그인</button>
              </div>
              <!--                   <div class="form-group"> -->
              <!--                     <button class="btn btn-block btn-round btn-b" onclick="()"><i class="fa fa-github"></i> Login with Github</button> -->
              <!--                   </div> -->
              <!--                   <div class="form-group"> -->
              <!--                     <button class="btn btn-block btn-round btn-b" id="GgCustomLogin" onclick="githubLogin();"><i class="fa fa-google"></i> Login with Google</button> -->
              <!--                   </div> -->
              <!--                   <div class="form-group"> -->
              <!--                     <button class="btn btn-block btn-round btn-b" onclick="kakaoLogin();"><i class="fa fa-comment-o"></i> Login with Kakao</button> -->
              <!--                   </div> -->
            </form>
          </div>
        </div>
      </div>
    </section>
  </div>

  <script>
    $('.testMemBtn').on('click', function () {
      event.preventDefault();
      $('#username').val($(this).data('id'));
      $('#password').val('java');
      $('#loginSubmit').click();
    })
    $('.testAdminBtn').on('click', function () {
      event.preventDefault();
      window.location.href = '/admin';
    })

    // 한글 입력 방지
    var idInput = document.querySelector('#username');
    var pwInput = document.querySelector('#password');

    var korean = function () {
      var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
      this.value = this.value.replace(pattern, '');
    };

    idInput.addEventListener('keyup', korean);
    pwInput.addEventListener('keyup', korean);

  </script>