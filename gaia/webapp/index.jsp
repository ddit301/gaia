<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>Launch Order System for DDIT</title>
  <link rel="stylesheet" href="fontawesome-5.5/css/all.min.css" />
  <link rel="stylesheet" href="slick/slick.css">
  <link rel="stylesheet" href="slick/slick-theme.css">
  <link rel="stylesheet" href="magnific-popup/magnific-popup.css">
  <link rel="stylesheet" href="css/bootstrap.min.css" />
  <link rel="stylesheet" href="css/tooplate-infinite-loop.css" />
 

</head>

<body>
<%
	Cookie[] cookies = request.getCookies();
	String loginId = "";
	String loginName = "Login";
	if(cookies != null){
		for(Cookie tmp : cookies){
			String value = URLDecoder.decode(tmp.getValue(),"utf-8");
			if("loginId".equals(tmp.getName())){
				loginId = URLDecoder.decode(tmp.getValue(),"utf-8");
			}
			if("loginName".equals(tmp.getName())){
				loginName = URLDecoder.decode(tmp.getValue(),"utf-8");
			}
		}
	}
	pageContext.setAttribute("loginName", loginName);
	pageContext.setAttribute("loginId", loginId);
%>
  <!-- Hero section -->
  <section id="infinite" class="text-white tm-font-big tm-parallax">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-md tm-navbar" id="tmNav">
      <div class="container">
        <div class="tm-next">
          <a href="#infinite" class="navbar-brand">Merry Meals</a>
        </div>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <i class="fas fa-bars navbar-toggler-icon"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto">
            
            <li class="nav-item">
              <a class="nav-link tm-nav-link" href="#whatwedo">Order</a>
            </li>
            <li class="nav-item">
              <a class="nav-link tm-nav-link" href="#testimonials">Testimonials</a>
            </li>
            <li class="nav-item">
              <a class="nav-link tm-nav-link" href="#gallery">Watch more</a>
            </li>
            <li class="nav-item">
              <a class="nav-link tm-nav-link" href="#contact">Contact</a>
            </li>
            <li class="nav-item">
              <a class="nav-link tm-nav-link" onclick='location.href="login/loginCheck.do"'>${loginName}</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="text-center tm-hero-text-container">
      <div class="tm-hero-text-container-inner">
        <h2 class="tm-hero-title">Lunch Order System</h2>
        <p class="tm-hero-subtitle">

          <br>launched by NOTCH
        </p>
      </div>
    </div>

    <div class="tm-next tm-intro-next">
      <a href="#whatwedo" class="text-center tm-down-arrow-link">
        <i class="fas fa-2x fa-arrow-down tm-down-arrow"></i>
      </a>
    </div>
  </section>

  <section id="whatwedo" class="tm-section-pad-top">

    <div class="container">

      <div class="row tm-content-box">
        <!-- first row -->
        <div class="col-lg-12 col-xl-12">
          <div class="tm-intro-text-container">
            <h2 class="tm-text-primary mb-4 tm-section-title">ORDER</h2>
            <p class="mb-4 tm-intro-text">

            <div class="row">
              <div class="col-md-3">
                <select class="custom-select">
                  <option>대전 도시락</option>
                  <option>토마토 도시락</option>
                  <option>서브웨이</option>
                  <option>메가커피</option>
                </select>
              </div>
              의
              <!-- </div>
            <div class="row"> -->
              <div class="col-md-3">
                <select class="custom-select">
                  <option>기본 메뉴</option>
                  <option>새우 치킨 샐러드</option>
                  <option>BLT</option>
                  <option>아이스아메리카노</option>
                </select>
              </div>
              메뉴
              <div class="col-md-3">
                <select class="custom-select">
                  <option>기본 옵션</option>
                  <option>유린기 소스</option>
                </select>
              </div>
              옵션
              <a href="https://fb.com/tooplate">으로 주문하기</a>.</p>
            </div>

          </div>
        </div>
        <!-- </div> -->
      </div><!-- first row -->

      <div class="row tm-content-box">
        <!-- third row -->
        <!-- <div class="col-lg-1">
            <i class="fas fa-3x fa-fingerprint text-center tm-icon"></i>
          </div> -->
        <div class="col-lg-12 col-xl-12">
          <div class="tm-intro-text-container">
            <h2 class="tm-text-primary mb-4">Taken</h2>
            <div class="table">
              <p class="mb-4 tm-intro-text">
                <strong>이름</strong>님이 <strong>토마토 도시락</strong>의 <strong>새우 치킨 샐러드</strong>메뉴
                <strong>유린기 소스</strong>옵션으로 주문 완료
              </p>
              <a href="#testimonials" class="tm-intro-text tm-btn-primary">입금 완료</a>

              <a href="#testimonials" class="tm-intro-text tm-btn-primary">입금 확인</a>

              <a href="#testimonials" class="tm-intro-text tm-btn-primary">주문 취소</a>
            </div>
            <div class="table">
              <p class="mb-4 tm-intro-text">
                <strong>이름</strong>님이 <strong>토마토 도시락</strong>의 <strong>새우 치킨 샐러드</strong>메뉴
                <strong>유린기 소스</strong>옵션으로 주문 완료
              </p>
              <a href="#testimonials" class="tm-intro-text tm-btn-primary">입금 완료</a>

              <a href="#testimonials" class="tm-intro-text tm-btn-primary">입금 확인</a>

              <a href="#testimonials" class="tm-intro-text tm-btn-primary">주문 취소</a>
            </div>
            <div class="table">
              <p class="mb-4 tm-intro-text">
                <strong>이름</strong>님이 <strong>토마토 도시락</strong>의 <strong>새우 치킨 샐러드</strong>메뉴
                <strong>유린기 소스</strong>옵션으로 주문 완료
              </p>
              <a href="#testimonials" class="tm-intro-text tm-btn-primary">입금 완료</a>

              <a href="#testimonials" class="tm-intro-text tm-btn-primary">입금 확인</a>

              <a href="#testimonials" class="tm-intro-text tm-btn-primary">주문 취소</a>
            </div>
          </div>
        </div>
      </div>

      <div class="row tm-content-box">



        <div class="col-lg-1">
          <i class="fas fa-3x fa-users text-center tm-icon"></i>
        </div>
        <div class="col-lg-12 col-xl-12">
          <div class="tm-intro-text-container">
            <h2 class="tm-text-primary mb-4">Testimonials</h2>
            <p class="mb-4 tm-intro-text">
              <b><em>Recommand Lunch Menu.</em></b>
              <br><a href="https://fontawesome.com/icons?d=gallery">Add Launch Menu</a> to DB.
              <em>&lt;i class=&quot;fas fa-users&quot;&gt;&lt;i class=&quot;far fa-chart-bar&quot;&gt;</em>You can
              <strong>use</strong> this template for your commercial websites.
            </p>
            </p>

            <div class="tm-continue">
              <a href="#testimonials" class="tm-intro-text tm-btn-primary">Details</a>
            </div>
          </div>
        </div>

      </div><!-- third row -->
      <!-- </div> -->
    </div>


  </section>

  <section id="testimonials" class="tm-section-pad-top tm-parallax-2">
    <div class="container tm-testimonials-content">
      <div class="row">
        <div class="col-lg-12 tm-content-box">
          <h2 class="text-white text-center mb-4 tm-section-title">Testimonials</h2>
          <p class="mx-auto tm-section-desc text-center">
            Nulla dictum sem non eros euismod, eu placerat tortor lobortis. Suspendisse id velit eu libero pellentesque
            interdum. Etiam quis congue eros.
          </p>
          <div class="mx-auto tm-gallery-container tm-gallery-container-2">
            <div class="tm-testimonials-carousel">
              <figure class="tm-testimonial-item">
                <img src="img/testimonial-img-01.jpg" alt="Image" class="img-fluid mx-auto">
                <blockquote>This background image includes a semi-transparent overlay layer. This section also has a
                  parallax image effect.</blockquote>
                <figcaption>Josh (DA)</figcaption>
              </figure>

              <figure class="tm-testimonial-item">
                <img src="img/testimonial-img-02.jpg" alt="Image" class="img-fluid mx-auto">
                <blockquote>Testimonial section comes with carousel items. You can use Infinite Loop HTML CSS template
                  for your websites.</blockquote>
                <figcaption>Shane (PL/AA)</figcaption>
              </figure>

              <figure class="tm-testimonial-item">
                <img src="img/testimonial-img-03.jpg" alt="Image" class="img-fluid mx-auto">
                <blockquote>Nulla finibus ligula nec tortor convallis tincidunt. Interdum et malesuada fames ac ante
                  ipsum primis in faucibus.</blockquote>
                <figcaption>Robin (QA/UA)</figcaption>
              </figure>

              <figure class="tm-testimonial-item">
                <img src="img/testimonial-img-04.jpg" alt="Image" class="img-fluid mx-auto">
                <blockquote>Curabitur rutrum pharetra lobortis. Pellentesque vehicula, velit quis eleifend fermentum,
                  erat arcu aliquet neque.</blockquote>
                <figcaption>Gil (TA)</figcaption>
              </figure>

            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="tm-bg-overlay"></div>
  </section>

  <section id="gallery" class="tm-section-pad-top">
    <div class="container tm-container-gallery">
      <div class="row">
        <div class="text-center col-12">
          <h2 class="tm-text-primary tm-section-title mb-4">See More Works</h2>
          <p class="mx-auto tm-section-desc">
            All of works we did until completion. Most of them is Middle projects.
          </p>
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <div class="mx-auto tm-gallery-container">
            <div class="grid tm-gallery">
              <a href="img/gallery-img-01.jpg">
                <figure class="effect-honey tm-gallery-item">
                  <img src="img/gallery-tn-01.jpg" alt="Image 1" class="img-fluid">
                  <figcaption>
                    <h2><i>SNS FOR DDIT <br><span>"PLAY DDIT"</span></i></h2>
                  </figcaption>
                </figure>
              </a>
              <a href="img/gallery-img-02.jpg">
                <figure class="effect-honey tm-gallery-item">
                  <img src="img/gallery-tn-02.jpg" alt="Image 2" class="img-fluid">
                  <figcaption>
                    <h2><i><span>"TRAVELER"</span> ANYWHERE YOU LOVE</i></h2>
                  </figcaption>
                </figure>
              </a>
              <a href="img/gallery-img-03.jpg">
                <figure class="effect-honey tm-gallery-item">
                  <img src="img/gallery-tn-03.jpg" alt="Image 3" class="img-fluid">
                  <figcaption>
                    <h2><i>GENERAL COOKING PLATFORM <br><span>"RECIBEE"</span></i></h2>
                  </figcaption>
                </figure>
              </a>
              <a href="img/gallery-img-04.jpg">
                <figure class="effect-honey tm-gallery-item">
                  <img src="img/gallery-tn-04.jpg" alt="Image 4" class="img-fluid">
                  <figcaption>
                    <h2><i>Dream Girl <span>Thoughts</span></i></h2>
                  </figcaption>
                </figure>
              </a>
              <a href="img/gallery-img-05.jpg">
                <figure class="effect-honey tm-gallery-item">
                  <img src="img/gallery-tn-05.jpg" alt="Image 5" class="img-fluid">
                  <figcaption>
                    <h2><i><span>Workstation</span> Offices</i></h2>
                  </figcaption>
                </figure>
              </a>
              <a href="img/gallery-img-06.jpg">
                <figure class="effect-honey tm-gallery-item">
                  <img src="img/gallery-tn-06.jpg" alt="Image 6" class="img-fluid">
                  <figcaption>
                    <h2><i>Just Above <span>The City</span></i></h2>
                  </figcaption>
                </figure>
              </a>

            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Contact -->
  <section id="contact" class="tm-section-pad-top tm-parallax-2">

    <div class="container tm-container-contact">

      <div class="row">

        <div class="text-center col-12">
          <h2 class="tm-section-title mb-4">Contact Us</h2>
          <p class="mb-5">
            All of your feedback would be pleased.
          </p><br>
        </div>

        <div class="col-sm-12 col-md-6">
          <form action="" method="get">
            <input id="name" name="name" type="text" placeholder="Your Name" class="tm-input" required />
            <input id="email" name="email" type="email" placeholder="Your Email" class="tm-input" required />
            <textarea id="message" name="message" rows="8" placeholder="Message" class="tm-input" required></textarea>
            <button type="submit" class="btn tm-btn-submit">Submit</button>
          </form>
        </div>

        <div class="col-sm-12 col-md-6">

          <div class="contact-item">
            <a rel="nofollow" href="https://www.tooplate.com/contact" class="item-link">
              <i class="far fa-2x fa-comment mr-4"></i>
              <span class="mb-0">Chat Online</span>
            </a>
          </div>

          <div class="contact-item">
            <a rel="nofollow" href="mailto:mail@company.com" class="item-link">
              <i class="far fa-2x fa-envelope mr-4"></i>
              <span class="mb-0">mail@company.com</span>
            </a>
          </div>

          <div class="contact-item">
            <a rel="nofollow" href="https://www.google.com/maps" class="item-link">
              <i class="fas fa-2x fa-map-marker-alt mr-4"></i>
              <span class="mb-0">DDIT 301 </span>
            </a>
          </div>

          <div class="contact-item">
            <a rel="nofollow" href="tel:0100200340" class="item-link">
              <i class="fas fa-2x fa-phone-square mr-4"></i>
              <span class="mb-0">042-222-8202</span>
            </a>
          </div>

          <div class="contact-item">&nbsp;</div>

        </div>


      </div><!-- row ending -->

    </div>

    <footer class="text-center small tm-footer">
      <p class="mb-0">
        Copyright &copy; 2021 NOTCH

        . <a rel="nofollow" href="https://www.tooplate.com" title="HTML templates">Designed by Robin</a></p>
    </footer>

  </section>

  <script src="js/jquery-1.9.1.min.js"></script>
  <script src="slick/slick.min.js"></script>
  <script src="magnific-popup/jquery.magnific-popup.min.js"></script>
  <script src="js/easing.min.js"></script>
  <script src="js/jquery.singlePageNav.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script>

    function getOffSet() {
      var _offset = 450;
      var windowHeight = window.innerHeight;

      if (windowHeight > 500) {
        _offset = 400;
      }
      if (windowHeight > 680) {
        _offset = 300
      }
      if (windowHeight > 830) {
        _offset = 210;
      }

      return _offset;
    }

    function setParallaxPosition($doc, multiplier, $object) {
      var offset = getOffSet();
      var from_top = $doc.scrollTop(),
        bg_css = 'center ' + (multiplier * from_top - offset) + 'px';
      $object.css({ "background-position": bg_css });
    }

    // Parallax function
    // Adapted based on https://codepen.io/roborich/pen/wpAsm        
    var background_image_parallax = function ($object, multiplier, forceSet) {
      multiplier = typeof multiplier !== 'undefined' ? multiplier : 0.5;
      multiplier = 1 - multiplier;
      var $doc = $(document);
      // $object.css({"background-attatchment" : "fixed"});

      if (forceSet) {
        setParallaxPosition($doc, multiplier, $object);
      } else {
        $(window).scroll(function () {
          setParallaxPosition($doc, multiplier, $object);
        });
      }
    };

    var background_image_parallax_2 = function ($object, multiplier) {
      multiplier = typeof multiplier !== 'undefined' ? multiplier : 0.5;
      multiplier = 1 - multiplier;
      var $doc = $(document);
      $object.css({ "background-attachment": "fixed" });

      $(window).scroll(function () {
        if ($(window).width() > 768) {
          var firstTop = $object.offset().top,
            pos = $(window).scrollTop(),
            yPos = Math.round((multiplier * (firstTop - pos)) - 186);

          var bg_css = 'center ' + yPos + 'px';

          $object.css({ "background-position": bg_css });
        } else {
          $object.css({ "background-position": "center" });
        }
      });
    };

    $(function () {
      // Hero Section - Background Parallax
      background_image_parallax($(".tm-parallax"), 0.30, false);
      background_image_parallax_2($("#contact"), 0.80);
      background_image_parallax_2($("#testimonials"), 0.80);

      // Handle window resize
      window.addEventListener('resize', function () {
        background_image_parallax($(".tm-parallax"), 0.30, true);
      }, true);

      // Detect window scroll and update navbar
      $(window).scroll(function (e) {
        if ($(document).scrollTop() > 120) {
          $('.tm-navbar').addClass("scroll");
        } else {
          $('.tm-navbar').removeClass("scroll");
        }
      });

      // Close mobile menu after click 
      $('#tmNav a').on('click', function () {
        $('.navbar-collapse').removeClass('show');
      })

      // Scroll to corresponding section with animation
      $('#tmNav').singlePageNav({
        'easing': 'easeInOutExpo',
        'speed': 600
      });

      // Add smooth scrolling to all links
      // https://www.w3schools.com/howto/howto_css_smooth_scroll.asp
      $("a").on('click', function (event) {
        if (this.hash !== "") {
          event.preventDefault();
          var hash = this.hash;

          $('html, body').animate({
            scrollTop: $(hash).offset().top
          }, 600, 'easeInOutExpo', function () {
            window.location.hash = hash;
          });
        } // End if
      });

      // Pop up
      $('.tm-gallery').magnificPopup({
        delegate: 'a',
        type: 'image',
        gallery: { enabled: true }
      });

      $('.tm-testimonials-carousel').slick({
        dots: true,
        prevArrow: false,
        nextArrow: false,
        infinite: false,
        slidesToShow: 3,
        slidesToScroll: 1,
        responsive: [
          {
            breakpoint: 992,
            settings: {
              slidesToShow: 2
            }
          },
          {
            breakpoint: 768,
            settings: {
              slidesToShow: 2
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1
            }
          }
        ]
      });

      // Gallery
      $('.tm-gallery').slick({
        dots: true,
        infinite: false,
        slidesToShow: 5,
        slidesToScroll: 2,
        responsive: [
          {
            breakpoint: 1199,
            settings: {
              slidesToShow: 4,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 991,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 767,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 1
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
        ]
      });
    });
  </script>
</body>

</html>