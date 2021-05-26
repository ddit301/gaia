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
                <h4 class="font-alt">Sign in</h4>
                <hr class="divider-w mb-10">
                <form class="form" method="post" action="${pageContext.request.contextPath }/signin/signinCheck">
                  <div class="form-group">
                    <input class="form-control" id="username" type="text" name="mem_id" placeholder="Username"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="password" type="password" name="mem_pass" placeholder="Password"/>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" onclick="()">Login</button>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" onclick="()"><i class="fa fa-github"></i> Login with Github</button>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" id="GgCustomLogin" onclick="githubLogin();"><i class="fa fa-google"></i> Login with Google</button>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" onclick="alert('aaaa');kakaoLogin();"><i class="fa fa-comment-o"></i> Login with Kakao</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
       </div>
    <!--  
    JavaScripts
    =============================================
    -->
    
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
    
    <script src="/gaia/resources/main/lib/jquery/dist/jquery.js"></script>
    <script src="/gaia/resources/main/lib/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="/gaia/resources/main/lib/wow/dist/wow.js"></script>
    <script src="/gaia/resources/main/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
    <script src="/gaia/resources/main/lib/isotope/dist/isotope.pkgd.js"></script>
    <script src="/gaia/resources/main/lib/imagesloaded/imagesloaded.pkgd.js"></script>
    <script src="/gaia/resources/main/lib/flexslider/jquery.flexslider.js"></script>
    <script src="/gaia/resources/main/lib/owl.carousel/dist/owl.carousel.min.js"></script>
    <script src="/gaia/resources/main/lib/smoothscroll.js"></script>
    <script src="/gaia/resources/main/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
    <script src="/gaia/resources/main/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
    <script src="/gaia/resources/main/js/plugins.js"></script>
    <script src="/gaia/resources/main/js/main.js"></script>