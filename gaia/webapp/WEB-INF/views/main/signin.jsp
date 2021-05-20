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
                <form class="form">
                  <div class="form-group">
                    <input class="form-control" id="username" type="text" name="username" placeholder="Username"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="password" type="password" name="password" placeholder="Password"/>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" onclick="()">Login</button>
                  </div>
                </form>
                  <div class="form-group">
					<div class="bg-contain" style="background-image:url(resources/main/images/kakao_login.png)" onclick="kakaoLogin()"></div>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" onclick="()">GOOGLE Login</button>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" onclick="()">GITHUB Login</button>
                  </div>
                  <div class="form-group"><a href="">Forgot Password?</a></div>
              </div>
            </div>
          </div>
        </section>
       </div>
    <!--  
    JavaScripts
    =============================================
    -->
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