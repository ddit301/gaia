<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="UTF-8" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--
    Document Title
    =============================================
    -->
    <title>GAIA</title>
    <!--
    Favicons
    =============================================
    -->
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
    <!--
    Stylesheets
    =============================================
    -->
    <!-- Default stylesheets-->
    
    
    <link href="resources/main/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Template specific stylesheets-->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Volkhov:400i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,600,700,800" rel="stylesheet">
    <link href="resources/main/lib/animate.css/animate.css" rel="stylesheet">
    <link href="resources/main/lib/components-font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="resources/main/lib/et-line-font/et-line-font.css" rel="stylesheet">
    <link href="resources/main/lib/flexslider/flexslider.css" rel="stylesheet">
    <link href="resources/main/lib/owl.carousel/dist/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="resources/main/lib/owl.carousel/dist/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="resources/main/lib/magnific-popup/dist/magnific-popup.css" rel="stylesheet">
    <link href="resources/main/lib/simple-text-rotator/simpletextrotator.css" rel="stylesheet">
    <!-- Custom Stylesheet -->
    
    
    <!-- Main stylesheet and color file-->
    <link href="resources/main/css/style.css" rel="stylesheet">
    <link href="resources/main/css/admin-style.css" rel="stylesheet">
    <link id="color-scheme" href="resources/main/css/colors/default.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
<!--     <link href="resources/main/css/jquery.dataTables.css" rel="stylesheet"> -->


	<script src="resources/main/lib/jquery/dist/jquery.js"></script>
    <script defer src="resources/main/lib/bootstrap/dist/js/bootstrap.min.js"></script>
    <script defer src="resources/main/lib/wow/dist/wow.js"></script>
    <script defer src="resources/main/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
    <script defer src="resources/main/lib/isotope/dist/isotope.pkgd.js"></script>
    <script defer src="resources/main/lib/imagesloaded/imagesloaded.pkgd.js"></script>
    <script defer src="resources/main/lib/flexslider/jquery.flexslider.js"></script>
    <script defer src="resources/main/lib/owl.carousel/dist/owl.carousel.min.js"></script>
    <script defer src="resources/main/lib/smoothscroll.js"></script>
    <script defer src="resources/main/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
    <script defer src="resources/main/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
    <script defer src="resources/main/js/plugins.js"></script>
    <script defer src="resources/main/js/main.js"></script>
    <script defer src="resources/main/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'G-3YZPKG0D0K');
      
    function getContextPath() {
        return "<%=request.getContextPath()%>";
    }
    </script>





    <style type="text/css">
    .quesadilla{
	  position:relative;
	}
	.quesadilla:after{
	  z-index:-1;//this unblock the click
	  content:'📅';//your image or whateaver
	  display: block;
	  font-size:2rem;
	  color:STEELBLUE;
	  background: none;
	  //background: url('') no-repeat;
	  //background-size: 10%;
	  width: 50px;
	  height: 50px;
	  position: absolute;
	  top:13px;
	  right:-7px;
	}
    
    </style>
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
    <main id="mainNav">
      <div class="page-loader">
        <div class="loader">Loading...</div>
      </div>
      <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="container">
          <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#custom-collapse"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a class="navbar-brand" href="/gaia/admin">GAIA ADMIN</a>
          </div>
          <div class="collapse navbar-collapse" id="custom-collapse">
            <div class="space-between">
            <ul class="nav navbar-nav navbar-left">
              <li class=""><a href="#"  data-menu = "admin/member">회원조회</a>
              </li>
              <li class=""><a href="#" data-menu = "">결제내역확인</a>
              </li>
              <li class=""><a href="#"  data-menu = "admin/inquiry">1:1문의 관리</a>
              </li>
              <li class=""><a href="#" data-menu = "admin/statics">통계</a>
              </li>
              <li class=""><a href="#" data-menu = "monitoring">서버환경 조회</a>
              </li>
            </ul>
            </div>
            <div class="space-between">
           	<ul class="nav navbar-nav navbar-right
           	">
              <li class=""><a class="" href="#" onclick="javascript:asyncMovePage('${cPath}/signout');" data-toggle="">Sign out</a>
              </ul>
            </div>
          </div>

        </div>
      </nav>




	</main>
	<main id="mainBody">

<!-- 	default included page -->
	<jsp:include page="member.jsp"></jsp:include>

    </main>
    
    <main id="mainFooter">
    <div class="module-small bg-dark">
          <div class="container">
            <div class="row">
              <div class="col-sm-3">
                <div class="widget">
                  <h5 class="widget-title font-alt">About SEED</h5>
                  <p>The languages only differ in their grammar, their pronunciation and their most common words.</p>
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
                      <div class="widget-posts-image"><a href="#"><img src="main/images/rp-1.jpg" alt="Post Thumbnail"/></a></div>
                      <div class="widget-posts-body">
                        <div class="widget-posts-title"><a href="#">Designer Desk Essentials</a></div>
                        <div class="widget-posts-meta">23 january</div>
                      </div>
                    </li>
                    <li class="clearfix">
                      <div class="widget-posts-image"><a href="#"><img src="main/images/rp-2.jpg" alt="Post Thumbnail"/></a></div>
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
                <p class="copyright font-alt">&copy; 2021&nbsp;<a href="index.html">team SEED</a>, All Rights Reserved</p>
              </div>
              <div class="col-sm-6">
                <div class="footer-social-links"><a href="#"><i class="fa fa-github"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-skype"></i></a>
                </div>
              </div>
            </div>
          </div>
        </footer>
      <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>
    </main>


   

  </body>
</html>
