
/* ---------------------------------------------- /*
 * Preloader
 /* ---------------------------------------------- */
(function () {
    $(window).on('load', function () {
        $('.loader').fadeOut();
        $('.page-loader').delay(350).fadeOut('slow');
    });

    $(document).ready(function () {

        /* ---------------------------------------------- /*
         * WOW Animation When You Scroll
         /* ---------------------------------------------- */

        wow = new WOW({
            mobile: false
        });
        wow.init();


        /* ---------------------------------------------- /*
         * Scroll top
         /* ---------------------------------------------- */

        $(window).scroll(function () {
            if ($(this).scrollTop() > 100) {
                $('.scroll-up').fadeIn();
            } else {
                $('.scroll-up').fadeOut();
            }
        });

        $('a[href="#totop"]').click(function () {
            $('html, body').animate({ scrollTop: 0 }, 'slow');
            return false;
        });


        /* ---------------------------------------------- /*
         * Initialization General Scripts for all pages
         /* ---------------------------------------------- */

        let homeSection = $('.home-section'),
            navbar = $('.navbar-custom'),
            navHeight = navbar.height(),
            worksgrid = $('#works-grid'),
            width = Math.max($(window).width(), window.innerWidth),
            mobileTest = false;

        if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            mobileTest = true;
        }

        buildHomeSection(homeSection);
        navbarAnimation(navbar, homeSection, navHeight);
        navbarSubmenu(width);
        hoverDropdown(width, mobileTest);

        $(window).resize(function () {
            let width = Math.max($(window).width(), window.innerWidth);
            buildHomeSection(homeSection);
            hoverDropdown(width, mobileTest);
        });

        $(window).scroll(function () {
            effectsHomeSection(homeSection, this);
            navbarAnimation(navbar, homeSection, navHeight);
        });

        /* ---------------------------------------------- /*
         * Set sections backgrounds
         /* ---------------------------------------------- */

        let module = $('.home-section, .module, .module-small, .side-image');
        module.each(function (i) {
            if ($(this).attr('data-background')) {
                $(this).css('background-image', 'url(' + $(this).attr('data-background') + ')');
            }
        });

        /* ---------------------------------------------- /*
         * Home section height
         /* ---------------------------------------------- */

        function buildHomeSection(homeSection) {
            if (homeSection.length > 0) {
                if (homeSection.hasClass('home-full-height')) {
                    homeSection.height($(window).height());
                } else {
                    homeSection.height($(window).height() * 0.85);
                }
            }
        }


        /* ---------------------------------------------- /*
         * Home section effects
         /* ---------------------------------------------- */

        function effectsHomeSection(homeSection, scrollTopp) {
            if (homeSection.length > 0) {
                let homeSHeight = homeSection.height();
                let topScroll = $(document).scrollTop();
                if ((homeSection.hasClass('home-parallax')) && ($(scrollTopp).scrollTop() <= homeSHeight)) {
                    homeSection.css('top', (topScroll * 0.55));
                }
                if (homeSection.hasClass('home-fade') && ($(scrollTopp).scrollTop() <= homeSHeight)) {
                    let caption = $('.caption-content');
                    caption.css('opacity', (1 - topScroll / homeSection.height() * 1));
                }
            }
        }

        /* ---------------------------------------------- /*
         * Intro slider setup
         /* ---------------------------------------------- */

        if ($('.hero-slider').length > 0) {
            $('.hero-slider').flexslider({
                animation: "fade",
                animationSpeed: 1000,
                animationLoop: true,
                prevText: '',
                nextText: '',
                before: function (slider) {
                    $('.titan-caption').fadeOut().animate({ top: '-80px' }, { queue: false, easing: 'swing', duration: 700 });
                    slider.slides.eq(slider.currentSlide).delay(500);
                    slider.slides.eq(slider.animatingTo).delay(500);
                },
                after: function (slider) {
                    $('.titan-caption').fadeIn().animate({ top: '0' }, { queue: false, easing: 'swing', duration: 700 });
                },
                useCSS: true
            });
        }


        /* ---------------------------------------------- /*
         * Rotate
         /* ---------------------------------------------- */

        $(".rotate").textrotator({
            animation: "dissolve",
            separator: "|",
            speed: 3000
        });


        /* ---------------------------------------------- /*
         * Transparent navbar animation
         /* ---------------------------------------------- */

        function navbarAnimation(navbar, homeSection, navHeight) {
            let topScroll = $(window).scrollTop();
            if (navbar.length > 0 && homeSection.length > 0) {
                if (topScroll >= navHeight) {
                    navbar.removeClass('navbar-transparent');
                } else {
                    navbar.addClass('navbar-transparent');
                }
            }
        }

        /* ---------------------------------------------- /*
         * Navbar submenu
         /* ---------------------------------------------- */

        function navbarSubmenu(width) {
            if (width > 767) {
                $('.navbar-custom .navbar-nav > li.dropdown').hover(function () {
                    let MenuLeftOffset = $('.dropdown-menu', $(this)).offset().left;
                    let Menu1LevelWidth = $('.dropdown-menu', $(this)).width();
                    if (width - MenuLeftOffset < Menu1LevelWidth * 2) {
                        $(this).children('.dropdown-menu').addClass('leftauto');
                    } else {
                        $(this).children('.dropdown-menu').removeClass('leftauto');
                    }
                    if ($('.dropdown', $(this)).length > 0) {
                        let Menu2LevelWidth = $('.dropdown-menu', $(this)).width();
                        if (width - MenuLeftOffset - Menu1LevelWidth < Menu2LevelWidth) {
                            $(this).children('.dropdown-menu').addClass('left-side');
                        } else {
                            $(this).children('.dropdown-menu').removeClass('left-side');
                        }
                    }
                });
            }
        }

        /* ---------------------------------------------- /*
         * Navbar hover dropdown on desctop
         /* ---------------------------------------------- */

        function hoverDropdown(width, mobileTest) {
            if ((width > 767) && (mobileTest !== true)) {
                $('.navbar-custom .navbar-nav > li.dropdown, .navbar-custom li.dropdown > ul > li.dropdown').removeClass('open');
                let delay = 0;
                let setTimeoutConst;
                $('.navbar-custom .navbar-nav > li.dropdown, .navbar-custom li.dropdown > ul > li.dropdown').hover(function () {
                    let $this = $(this);
                    setTimeoutConst = setTimeout(function () {
                        $this.addClass('open');
                        $this.find('.dropdown-toggle').addClass('disabled');
                    }, delay);
                },
                    function () {
                        clearTimeout(setTimeoutConst);
                        $(this).removeClass('open');
                        $(this).find('.dropdown-toggle').removeClass('disabled');
                    });
            } else {
                $('.navbar-custom .navbar-nav > li.dropdown, .navbar-custom li.dropdown > ul > li.dropdown').unbind('mouseenter mouseleave');
                $('.navbar-custom [data-toggle=dropdown]').not('.binded').addClass('binded').on('click', function (event) {
                    event.preventDefault();
                    event.stopPropagation();
                    $(this).parent().siblings().removeClass('open');
                    $(this).parent().siblings().find('[data-toggle=dropdown]').parent().removeClass('open');
                    $(this).parent().toggleClass('open');
                });
            }
        }

        /* ---------------------------------------------- /*
         * Navbar collapse on click
         /* ---------------------------------------------- */

        $(document).on('click', '.navbar-collapse.in', function (e) {
            if ($(e.target).is('a') && $(e.target).attr('class') != 'dropdown-toggle') {
                $(this).collapse('hide');
            }
        });


        /* ---------------------------------------------- /*
         * Video popup, Gallery
         /* ---------------------------------------------- */

        $('.video-pop-up').magnificPopup({
            type: 'iframe'
        });

        $(".gallery-item").magnificPopup({
            delegate: 'a',
            type: 'image',
            gallery: {
                enabled: true,
                navigateByImgClick: true,
                preload: [0, 1]
            },
            image: {
                titleSrc: 'title',
                tError: 'The image could not be loaded.'
            }
        });


        /* ---------------------------------------------- /*
         * Portfolio
         /* ---------------------------------------------- */

        let worksgrid_mode;

        if (worksgrid.hasClass('works-grid-masonry')) {
            worksgrid_mode = 'masonry';
        } else {
            worksgrid_mode = 'fitRows';
        }

        worksgrid.imagesLoaded(function () {
            worksgrid.isotope({
                layoutMode: worksgrid_mode,
                itemSelector: '.work-item'
            });
        });

        $('#filters a').click(function () {
            $('#filters .current').removeClass('current');
            $(this).addClass('current');
            let selector = $(this).attr('data-filter');

            worksgrid.isotope({
                filter: selector,
                animationOptions: {
                    duration: 750,
                    easing: 'linear',
                    queue: false
                }
            });

            return false;
        });


        /* ---------------------------------------------- /*
         * Testimonials
         /* ---------------------------------------------- */

        if ($('.testimonials-slider').length > 0) {
            $('.testimonials-slider').flexslider({
                animation: "slide",
                smoothHeight: true
            });
        }


        /* ---------------------------------------------- /*
         * Post Slider
         /* ---------------------------------------------- */

        if ($('.post-images-slider').length > 0) {
            $('.post-images-slider').flexslider({
                animation: "slide",
                smoothHeight: true,
            });
        }


        /* ---------------------------------------------- /*
         * Progress bar animations
         /* ---------------------------------------------- */

        $('.progress-bar').each(function (i) {
            $(this).appear(function () {
                let percent = $(this).attr('aria-valuenow');
                $(this).animate({ 'width': percent + '%' });
                $(this).find('span').animate({ 'opacity': 1 }, 900);
                $(this).find('span').countTo({ from: 0, to: percent, speed: 900, refreshInterval: 30 });
            });
        });


        /* ---------------------------------------------- /*
         * Funfact Count-up
         /* ---------------------------------------------- */

        $('.count-item').each(function (i) {
            $(this).appear(function () {
                let number = $(this).find('.count-to').data('countto');
                $(this).find('.count-to').countTo({ from: 0, to: number, speed: 1200, refreshInterval: 30 });
            });
        });


        /* ---------------------------------------------- /*
         * Youtube video background
         /* ---------------------------------------------- */

        $(function () {
            $(".video-player").mb_YTPlayer();
        });

        $('#video-play').click(function (event) {
            event.preventDefault();
            if ($(this).hasClass('fa-play')) {
                $('.video-player').playYTP();
            } else {
                $('.video-player').pauseYTP();
            }
            $(this).toggleClass('fa-play fa-pause');
            return false;
        });

        $('#video-volume').click(function (event) {
            event.preventDefault();
            if ($(this).hasClass('fa-volume-off')) {
                $('.video-player').YTPUnmute();
            } else {
                $('.video-player').YTPMute();
            }
            $(this).toggleClass('fa-volume-off fa-volume-up');
            return false;
        });


        /* ---------------------------------------------- /*
         * Owl Carousel
         /* ---------------------------------------------- */

        $('.owl-carousel').each(function (i) {

            // Check items number
            if ($(this).data('items') > 0) {
                items = $(this).data('items');
            } else {
                items = 4;
            }

            // Check pagination true/false
            if (($(this).data('pagination') > 0) && ($(this).data('pagination') === true)) {
                pagination = true;
            } else {
                pagination = false;
            }

            // Check navigation true/false
            if (($(this).data('navigation') > 0) && ($(this).data('navigation') === true)) {
                navigation = true;
            } else {
                navigation = false;
            }

            // Build carousel
            $(this).owlCarousel({
                navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
                nav: navigation,
                dots: pagination,
                loop: true,
                dotsSpeed: 400,
                items: items,
                navSpeed: 300,
                autoplay: 2000
            });

        });


        /* ---------------------------------------------- /*
         * Blog masonry
         /* ---------------------------------------------- */

        $('.post-masonry').imagesLoaded(function () {
            $('.post-masonry').masonry();
        });


        /* ---------------------------------------------- /*
         * Scroll Animation
         /* ---------------------------------------------- */

        $('.section-scroll').bind('click', function (e) {
            let anchor = $(this);
            $('html, body').stop().animate({
                scrollTop: $(anchor.attr('href')).offset().top - 50
            }, 1000);
            e.preventDefault();
        });

        /*===============================================================
         Working Contact Form
         ================================================================*/

        $("#contactForm").submit(function (e) {

            e.preventDefault();
            let $ = jQuery;

            let postData = $(this).serializeArray(),
                formURL = $(this).attr("action"),
                $cfResponse = $('#contactFormResponse'),
                $cfsubmit = $("#cfsubmit"),
                cfsubmitText = $cfsubmit.text();

            $cfsubmit.text("Sending...");


            $.ajax(
                {
                    url: formURL,
                    type: "POST",
                    data: postData,
                    success: function (data) {
                        $cfResponse.html(data);
                        $cfsubmit.text(cfsubmitText);
                        $('#contactForm input[name=name]').val('');
                        $('#contactForm input[name=email]').val('');
                        $('#contactForm textarea[name=message]').val('');
                    },
                    error: function (data) {
                        alert("Error occurd! Please try again");
                    }
                });

            return false;

        });


        /*===============================================================
         Working Request A Call Form
         ================================================================*/

        $("#requestACall").submit(function (e) {

            e.preventDefault();
            let $ = jQuery;

            let postData = $(this).serializeArray(),
                formURL = $(this).attr("action"),
                $cfResponse = $('#requestFormResponse'),
                $cfsubmit = $("#racSubmit"),
                cfsubmitText = $cfsubmit.text();

            $cfsubmit.text("Sending...");


            $.ajax(
                {
                    url: formURL,
                    type: "POST",
                    data: postData,
                    success: function (data) {
                        $cfResponse.html(data);
                        $cfsubmit.text(cfsubmitText);
                        $('#requestACall input[name=name]').val('');
                        $('#requestACall input[name=subject]').val('');
                        $('#requestACall textarea[name=phone]').val('');
                    },
                    error: function (data) {
                        alert("Error occurd! Please try again");
                    }
                });

            return false;

        });


        /*===============================================================
         Working Reservation Form
         ================================================================*/

        $("#reservationForm").submit(function (e) {

            e.preventDefault();
            let $ = jQuery;

            let postData = $(this).serializeArray(),
                formURL = $(this).attr("action"),
                $cfResponse = $('#reservationFormResponse'),
                $cfsubmit = $("#rfsubmit"),
                cfsubmitText = $cfsubmit.text();

            $cfsubmit.text("Sending...");


            $.ajax(
                {
                    url: formURL,
                    type: "POST",
                    data: postData,
                    success: function (data) {
                        $cfResponse.html(data);
                        $cfsubmit.text(cfsubmitText);
                        $('#reservationForm input[name=date]').val('');
                        $('#reservationForm input[name=time]').val('');
                        $('#reservationForm textarea[name=people]').val('');
                        $('#reservationForm textarea[name=email]').val('');
                    },
                    error: function (data) {
                        alert("Error occurd! Please try again");
                    }
                });

            return false;

        });


        /* ---------------------------------------------- /*
         * Subscribe form ajax
         /* ---------------------------------------------- */

        $('#subscription-form').submit(function (e) {

            e.preventDefault();
            let $form = $('#subscription-form');
            let submit = $('#subscription-form-submit');
            let ajaxResponse = $('#subscription-response');
            let email = $('input#semail').val();

            $.ajax({
                type: 'POST',
                url: 'assets/php/subscribe.php',
                dataType: 'json',
                data: {
                    email: email
                },
                cache: false,
                beforeSend: function (result) {
                    submit.empty();
                    submit.append('<i class="fa fa-cog fa-spin"></i> Wait...');
                },
                success: function (result) {
                    if (result.sendstatus == 1) {
                        ajaxResponse.html(result.message);
                        $form.fadeOut(500);
                    } else {
                        ajaxResponse.html(result.message);
                    }
                }
            });

        });


        /* ---------------------------------------------- /*
         * Google Map
         /* ---------------------------------------------- */

        if ($("#map").length == 0 || typeof google == 'undefined') return;

        // When the window has finished loading create our google map below
        google.maps.event.addDomListener(window, 'load', init);

        let mkr = new google.maps.LatLng(40.6700, -74.2000);
        let cntr = (mobileTest) ? mkr : new google.maps.LatLng(40.6700, -73.9400);

        function init() {
            // Basic options for a simple Google Map
            // For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
            let mapOptions = {
                // How zoomed in you want the map to start at (always required)
                zoom: 11,
                scrollwheel: false,
                // The latitude and longitude to center the map (always required)
                center: cntr, // New York

                // How you would like to style the map.
                // This is where you would paste any style found on Snazzy Maps.
                styles: [
                    {
                        "featureType": "all",
                        "elementType": "geometry.fill",
                        "stylers": [
                            {
                                "visibility": "on"
                            },
                            {
                                "saturation": "-11"
                            }
                        ]
                    },
                    {
                        "featureType": "administrative",
                        "elementType": "geometry.fill",
                        "stylers": [
                            {
                                "saturation": "22"
                            }
                        ]
                    },
                    {
                        "featureType": "administrative",
                        "elementType": "geometry.stroke",
                        "stylers": [
                            {
                                "saturation": "-58"
                            },
                            {
                                "color": "#cfcece"
                            }
                        ]
                    },
                    {
                        "featureType": "administrative",
                        "elementType": "labels.text",
                        "stylers": [
                            {
                                "color": "#f8f8f8"
                            }
                        ]
                    },
                    {
                        "featureType": "administrative",
                        "elementType": "labels.text.fill",
                        "stylers": [
                            {
                                "color": "#999999"
                            },
                            {
                                "visibility": "on"
                            }
                        ]
                    },
                    {
                        "featureType": "administrative",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                            {
                                "visibility": "on"
                            }
                        ]
                    },
                    {
                        "featureType": "administrative.country",
                        "elementType": "geometry.fill",
                        "stylers": [
                            {
                                "color": "#f9f9f9"
                            },
                            {
                                "visibility": "simplified"
                            }
                        ]
                    },
                    {
                        "featureType": "landscape",
                        "elementType": "all",
                        "stylers": [
                            {
                                "color": "#f2f2f2"
                            }
                        ]
                    },
                    {
                        "featureType": "landscape",
                        "elementType": "geometry",
                        "stylers": [
                            {
                                "saturation": "-19"
                            },
                            {
                                "lightness": "-2"
                            },
                            {
                                "visibility": "on"
                            }
                        ]
                    },
                    {
                        "featureType": "poi",
                        "elementType": "all",
                        "stylers": [
                            {
                                "visibility": "off"
                            }
                        ]
                    },
                    {
                        "featureType": "road",
                        "elementType": "all",
                        "stylers": [
                            {
                                "saturation": -100
                            },
                            {
                                "lightness": 45
                            }
                        ]
                    },
                    {
                        "featureType": "road.highway",
                        "elementType": "all",
                        "stylers": [
                            {
                                "visibility": "simplified"
                            }
                        ]
                    },
                    {
                        "featureType": "road.arterial",
                        "elementType": "labels.icon",
                        "stylers": [
                            {
                                "visibility": "off"
                            }
                        ]
                    },
                    {
                        "featureType": "transit",
                        "elementType": "all",
                        "stylers": [
                            {
                                "visibility": "off"
                            }
                        ]
                    },
                    {
                        "featureType": "water",
                        "elementType": "all",
                        "stylers": [
                            {
                                "color": "#d8e1e5"
                            },
                            {
                                "visibility": "on"
                            }
                        ]
                    },
                    {
                        "featureType": "water",
                        "elementType": "geometry.fill",
                        "stylers": [
                            {
                                "color": "#dedede"
                            }
                        ]
                    },
                    {
                        "featureType": "water",
                        "elementType": "labels.text",
                        "stylers": [
                            {
                                "color": "#cbcbcb"
                            }
                        ]
                    },
                    {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                            {
                                "color": "#9c9c9c"
                            }
                        ]
                    },
                    {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                            {
                                "visibility": "off"
                            }
                        ]
                    }
                ]
            };

            // Get the HTML DOM element that will contain your map
            // We are using a div with id="map" seen below in the <body>
            let mapElement = document.getElementById('map');

            // Create the Google Map using our element and options defined above
            let map = new google.maps.Map(mapElement, mapOptions);

            // Let's also add a marker while we're at it
            let image = new google.maps.MarkerImage('assets/images/map-icon.png',
                new google.maps.Size(59, 65),
                new google.maps.Point(0, 0),
                new google.maps.Point(24, 42)
            );

            let marker = new google.maps.Marker({
                position: mkr,
                icon: image,
                title: 'Titan',
                infoWindow: {
                    content: '<p><strong>Rival</strong><br/>121 Somewhere Ave, Suite 123<br/>P: (123) 456-7890<br/>Australia</p>'
                },
                map: map,
            });
        }

    });
})(jQuery);



function asyncMovePage(url){
    	
	var uri = getContextPath() + '/'+ url.substring(url.lastIndexOf('/')+1);
	history.pushState(null, null, uri);
    
}
    
$('.navbar-nav').on('click', 'a', function(){
	event.preventDefault();
	
	let menu_name = $(this).data('menu');
	if(! menu_name){
		return;	
	}
	let uri = getContextPath() + '/' + menu_name;
	history.pushState(null, null, uri);
    let pre_name = 'view/'
    if(menu_name.startsWith('admin'))
        pre_name = ''
		menu_name = menu_name.substring(menu_name.lastIndexOf('/')+1);
	
	let ajaxOption = {
            url : pre_name + menu_name,
            async : true,
            type : "GET",
            dataType : "html",
            cache : false
    };
    $.ajax(ajaxOption).done(function(data){
        $('#mainBody').children().remove();
        $('#mainBody').html(data);
        
    });
	//?????? ?????? ????????? 
	window.scrollTo(0,0);
	
	
})





function kakaoLogin() {
	
    window.open("https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=a31ddbbfbc730c92670b6e2f2ead67b5&redirect_uri=https://localhost/gaia/oauth/kakao&scope=account_email")

}

/*Kakao.init('247/*b2c770e06df0498165b888e0f11d5'); //???????????? ??? ??? javascript?????? ???????????????.
console.log(Kakao.isInitialized()); // sdk?????????????????????
//??????????????????
function kakaoLogin() {
	Kakao.Auth.authorize({
	  redirectUri: 'https://localhost/gaia/oauth/kakao'
	});*/
    /*Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })*/
  /*}*/
//?????????????????????  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  


function githubLogin() {
    window.location.href = "https://github.com/login/oauth/authorize?client_id=386c83173c32e10f3dbe&redirect_uri=http://localhost/gaia/oauth/github"
}


//google

function init() {
	gapi.load('auth2', function() {
		gapi.auth2.init();
		options = new gapi.auth2.SigninOptionsBuilder();
		options.setPrompt('select_account');
        // ????????? Oauth ?????? ?????? ?????? ??? ???????????? ???????????? ??????
		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
        // ??????????????? ?????? ?????? - element??? ????????? ?????? ??????
        // GgCustomLogin??? li???????????? ?????? ID, ?????? ????????? options??? ?????? ??????,????????? ???????????? ?????????
		gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
	})
}

function onSignIn(googleUser) {
	var access_token = googleUser.getAuthResponse().access_token
	$.ajax({
    	// people api??? ???????????? ????????? ??? ??????????????? ?????? ??????????????? ????????????.
		url: 'https://people.googleapis.com/v1/people/me'
        // key??? ????????? API ?????? ????????????.
		, data: {personFields:'birthdays', key:'AIzaSyANwjTQn-Og2Q5CuRA2NUhy2ddHaXa2UM4', 'access_token': access_token}
		, method:'GET'
	})
	.done(function(e){
        //???????????? ????????????.
		var profile = googleUser.getBasicProfile();
		console.log(profile)
	})
	.fail(function(e){
		console.log(e);
	})
}
function onSignInFailure(t){		
	console.log(t);
}



