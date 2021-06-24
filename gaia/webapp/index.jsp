<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<%@page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html lang="UTF-8" dir="ltr">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-signin-client_id"
  content="1033750193780-fvmn4gmbfnkd53av06di3cus2ri0j79c.apps.googleusercontent.com">
<!--Document Title=============================================-->
<title>GAIA</title>
<!--Favicons=============================================-->
<link rel="apple-touch-icon" sizes="57x57" href="resources/main/images/favicons/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="resources/main/images/favicons/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="resources/main/images/favicons/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="resources/main/images/favicons/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="resources/main/images/favicons/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="resources/main/images/favicons/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="resources/main/images/favicons/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="resources/main/images/favicons/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="resources/main/images/favicons/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192" href="resources/main/images/favicons/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="resources/main/images/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="resources/main/images/favicons/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="resources/main/images/favicons/favicon-16x16.png">
<link rel="manifest" href="resources/main/images/favicons/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="resources/main/images/favicons/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
<!--Stylesheets=============================================-->
<!-- Default stylesheets-->
<link href="resources/main/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Template specific stylesheets-->
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Volkhov:400i" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
<link href="resources/main/lib/animate.css/animate.css" rel="stylesheet">
<link href="resources/main/lib/components-font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="resources/main/lib/et-line-font/et-line-font.css" rel="stylesheet">
<link href="resources/main/lib/flexslider/flexslider.css" rel="stylesheet">
<link href="resources/main/lib/owl.carousel/dist/assets/owl.carousel.min.css" rel="stylesheet">
<link href="resources/main/lib/owl.carousel/dist/assets/owl.theme.default.min.css" rel="stylesheet">
<link href="resources/main/lib/magnific-popup/dist/magnific-popup.css" rel="stylesheet">
<link href="resources/main/lib/simple-text-rotator/simpletextrotator.css" rel="stylesheet">
<!-- Main stylesheet and color file-->
<link href="resources/main/css/style.css" rel="stylesheet">
<link id="color-scheme" href="resources/main/css/colors/default.css" rel="stylesheet">
<script src="resources/main/lib/jquery/dist/jquery.js"></script>

<script async src="https://www.googletagmanager.com/gtag/js?id=UA-190810131-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag() { dataLayer.push(arguments); }
  gtag('js', new Date());
  gtag('config', 'UA-190810131-3');

  function getContextPath() {
    return "<%=request.getContextPath()%>";
  }
  // 로그인 실패시 처리인데 어쩔수없이 일단 이렇게 짜뒀습니다.
  let authUser = '${sessionScope } ${authUser }'
  let message = null;
  if (authUser.includes('$$$')) {
    message = authUser.substring(authUser.indexOf('$$$') + 3);
    message = message.substring(0, message.indexOf('$$$'));
  }

</script>

</head>

<body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
<main id="mainNav">
<!--       <div class="page-loader"> -->
<!--         <div class="loader">Loading...</div> -->
<!--       </div> -->
  <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
    <div class="container">
      <div class="navbar-header">
        <button class="navbar-toggle" type="button" data-toggle="collapse"
          data-target="#custom-collapse"><span class="sr-only">Toggle navigation</span><span
            class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a
          class="navbar-brand" href="${cPath }">GAIA</a>
      </div>
      <div class="collapse navbar-collapse" id="custom-collapse">
<!--         <div class="space-between"> -->
<!--           <ul class="nav navbar-nav navbar-left"> -->
<!--             <li class=""><a href="#" data-menu="intro">소개</a> -->
<!--             </li> -->
<!--             <li class=""><a href="#" data-menu="demo">데모체험</a> -->
<!--             </li> -->
<!--             <li class=""><a href="#" data-menu="sales">요금안내</a> -->
<!--             </li> -->
<!--             <li class=""><a href="#" data-menu="updates">업데이트내역</a> -->
<!--             </li> -->
<!--             <li class=""><a href="#" data-menu="CS">고객센터</a> -->
<!--             </li> -->
<!--           </ul> -->
<!--         </div> -->
        <div class="space-between">
          <ul class="nav navbar-nav navbar-right">
            <security:authorize access="!isAuthenticated()">
              <li class=""><a class="" href="#" data-menu="signin" data-toggle="">Sign in</a>
              </li>
              <li class=""><a class="" href="#" data-menu="signup" data-toggle="">Sign up</a>
                <script>
                  $(function () {
                    if (message) {

                      $.ajax({
                        url: getContextPath() + '/signout',
                        method: 'get',
                        error: function (xhr, error, msg) {
                          ajaxError(xhr, error, msg);
                        }
                      })

                      alert(message);
                      menu_name = 'signin'
                      let uri = getContextPath() + '/' + menu_name;
                      history.pushState(null, null, uri);
                      let pre_name = 'view/'
                      if (menu_name.startsWith('admin'))
                        pre_name = ''
                      menu_name = menu_name.substring(menu_name.lastIndexOf('/') + 1);
                      console.log(pre_name + menu_name);

                      let ajaxOption = {
                        url: pre_name + menu_name,
                        async: true,
                        type: "GET",
                        dataType: "html",
                        cache: false
                      };
                      $.ajax(ajaxOption).done(function (data) {
                        $('#mainBody').children().remove();
                        $('#mainBody').html(data);

                      });
                      //화면 위로 올리기 
                      window.scrollTo(0, 0);
                    }
                  })
                </script>

            </security:authorize>
            <security:authorize access="isAuthenticated()">
              <security:authentication property="principal" var="authUser" />
              <script>
                var getCookie = function (name) {
                  let CookieValue = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
                  return CookieValue ? decodeURI(CookieValue[2]) : null;
                };
                window.location.href = getContextPath() + '/' + getCookie('mem_id') + '/overview';
              </script>
              <li class=""><a class="" href="${cPath }/signout" data-toggle="">Sign out</a>
              </li>
            </security:authorize>
          </ul>
        </div>
      </div>

    </div>
  </nav>

</main>
<main id="mainBody">

  <!-- default included page -->
  <jsp:include page="WEB-INF/views/main/intro.jsp"></jsp:include>

</main>







    
<!-- 여기서부 미사용 영역 -->





<main id="mainFooter">
  <div class="module-small bg-dark">
    <div class="container">
      <div class="row">
        <div class="col-sm-3">
          <div class="widget">
            <h5 class="widget-title font-alt">About SEED</h5>
            <p>The languages only differ in their grammar, their pronunciation and their most common words.
            </p>
            <p>Phone: +80 234 567 89 10</p>Fax: +1 234 567 89 10
            <p>Email:<a href="#">gaia@gaia.best</a></p>
          </div>
        </div>
        <div class="col-sm-3">
          <div class="widget">
            <h5 class="widget-title font-alt">Recent Comments</h5>
            <ul class="icon-list">
              <li>Shane on <a href="#">Designer Desk Essentials</a></li>
              <li>Robin on <a href="#">Realistic Business Card Mockup</a></li>
              <li>Josh on <a href="#">Eco bag Mockup</a></li>
              <li>Eisen on <a href="#">Bottle Mockup</a></li>
            </ul>
          </div>
        </div>

        <div class="col-sm-6">
          <div class="widget">
            <h5 class="widget-title font-alt">Popular Posts</h5>
            <ul class="widget-posts">
              <li class="clearfix">
                <div class="widget-posts-image"><a href="#"><img src="resources/main/images/rp-1.jpg"
                      alt="Post Thumbnail" /></a></div>
                <div class="widget-posts-body">
                  <div class="widget-posts-title"><a href="#">Designer Desk Essentials</a></div>
                  <div class="widget-posts-meta">23 january</div>
                </div>
              </li>
              <li class="clearfix">
                <div class="widget-posts-image"><a href="#"><img src="resources/main/images/rp-2.jpg"
                      alt="Post Thumbnail" /></a></div>
                <div class="widget-posts-body">
                  <div class="widget-posts-title"><a href="#">Realistic Business Card Mockup</a></div>
                  <div class="widget-posts-meta">15 February</div>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <hr class="divider-d">
  <footer class="footer bg-dark">
    <div class="container">
      <div class="row">
        <div class="col-sm-6">
          <p class="copyright font-alt">&copy; 2021&nbsp;<a href="index.html">team SEED</a>, All Rights
            Reserved</p>
        </div>
        <div class="col-sm-6">
          <div class="footer-social-links"><a href="#"><i class="fa fa-github"></i></a><a href="#"><i
                class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-skype"></i></a>
          </div>
        </div>
      </div>
    </div>
  </footer>
  <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>
</main>
  
  
  
  
<!-- 여기까지 미사용 영역  -->
  
  
  
  

<!--JavaScripts=============================================-->

<script src="resources/main/lib/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="resources/main/lib/wow/dist/wow.js"></script>
<script src="resources/main/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
<script src="resources/main/lib/isotope/dist/isotope.pkgd.js"></script>
<script src="resources/main/lib/imagesloaded/imagesloaded.pkgd.js"></script>
<script src="resources/main/lib/flexslider/jquery.flexslider.js"></script>
<script src="resources/main/lib/owl.carousel/dist/owl.carousel.min.js"></script>
<script src="resources/main/lib/smoothscroll.js"></script>
<script src="resources/main/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
<script src="resources/main/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
<script src="resources/main/js/plugins.js"></script>
<script src="resources/main/js/main.js"></script>

</body>

</html>