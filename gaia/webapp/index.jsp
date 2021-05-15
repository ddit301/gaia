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
    <link rel="apple-touch-icon" sizes="57x57" href="main/images/favicons/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="main/images/favicons/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="main/images/favicons/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="main/images/favicons/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="main/images/favicons/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="main/images/favicons/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="main/images/favicons/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="main/images/favicons/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="main/images/favicons/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="main/images/favicons/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="main/images/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="main/images/favicons/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="main/images/favicons/favicon-16x16.png">
    <link rel="manifest" href="main/images/favicons/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="main/images/favicons/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <!--
    Stylesheets
    =============================================
    -->
    <!-- Default stylesheets-->
    <link href="main/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Template specific stylesheets-->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Volkhov:400i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="main/lib/animate.css/animate.css" rel="stylesheet">
    <link href="main/lib/components-font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="main/lib/et-line-font/et-line-font.css" rel="stylesheet">
    <link href="main/lib/flexslider/flexslider.css" rel="stylesheet">
    <link href="main/lib/owl.carousel/dist/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="main/lib/owl.carousel/dist/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="main/lib/magnific-popup/dist/magnific-popup.css" rel="stylesheet">
    <link href="main/lib/simple-text-rotator/simpletextrotator.css" rel="stylesheet">
    <!-- Main stylesheet and color file-->
    <link href="main/css/style.css" rel="stylesheet">
    <link id="color-scheme" href="main/css/colors/default.css" rel="stylesheet">
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
    <main id="mainNav">
      <div class="page-loader">
        <div class="loader">Loading...</div>
      </div>
      <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="container">
          <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#custom-collapse"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a class="navbar-brand" href="/gaia">GAIA</a>
          </div>
          <div class="collapse navbar-collapse" id="custom-collapse">
            <div class="space-between">
            <ul class="nav navbar-nav navbar-left">
              <li class=""><a href="#" onclick="javascript:acyncMovePage('<%=request.getContextPath() %>/intro');">소개</a>
              </li>
              <li class=""><a href="#" onclick="javascript:acyncMovePage('<%=request.getContextPath() %>/demo');">데모체험</a>
              </li>
              <li class=""><a href="#" onclick="javascript:acyncMovePage('<%=request.getContextPath() %>/sales');">요금안내</a>
              </li>
              <li class=""><a href="#" onclick="javascript:acyncMovePage('<%=request.getContextPath() %>/updates');">업데이트내역</a>
              </li>
              <li class=""><a href="#" onclick="javascript:acyncMovePage('<%=request.getContextPath() %>/CS');">고객센터</a>
              </li>
            </ul>
            </div>
            <div class="space-between">
           	<ul class="nav navbar-nav navbar-right
           	">
              <li class=""><a class="" href="#" data-toggle="">Sign in</a>
              </li>
              <li class=""><a class="" href="#" data-toggle="">Sign up</a>
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
      </div>
      <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>
    </main>

    <!--
    JavaScripts
    =============================================
    -->

    <script src="main/lib/jquery/dist/jquery.js"></script>
    <script src="main/lib/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="main/lib/wow/dist/wow.js"></script>
    <script src="main/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
    <script src="main/lib/isotope/dist/isotope.pkgd.js"></script>
    <script src="main/lib/imagesloaded/imagesloaded.pkgd.js"></script>
    <script src="main/lib/flexslider/jquery.flexslider.js"></script>
    <script src="main/lib/owl.carousel/dist/owl.carousel.min.js"></script>
    <script src="main/lib/smoothscroll.js"></script>
    <script src="main/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
    <script src="main/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
    <script src="main/js/plugins.js"></script>
    <script src="main/js/main.js"></script>

    <script type="text/javascript">
    function acyncMovePage(url){
        // ajax option
        var ajaxOption = {
                url : url,
                async : true,
                type : "GET",
                dataType : "html",
                cache : false
//                 ,contentType:'text/html; charset=UTF-8'
        };

        $.ajax(ajaxOption).done(function(data){
            $('#mainBody').children().remove();
            $('#mainBody').html(data);
        });
    }
    </script>

  </body>
</html>
