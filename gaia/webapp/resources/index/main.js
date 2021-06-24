/* Author:

 */

$(function () {
    // fade in the site on DOM load
    $('html, body').animate({opacity: 1}, 1500);

    // Use Modernizr to detect for touch devices,
    // which don't support autoplay and may have less bandwidth,
    // so just give them the poster images instead
    var screenIndex = 1,
        numScreens = $('.screen').length,
        isTransitioning = false,
        transitionDur = 1000,
        BV,
        isTouch = Modernizr.touch,
        $bigImage = $('.big-image'),
        $window = $(window);

    if (!isTouch) {
        // initialize BigVideo
 /*       BV = new $.BigVideo({forceAutoplay: isTouch});
        BV.init();
        */

        showVideo();

       // BV.getPlayer().addEvent('loadeddata', function () {
       //     onVideoLoaded();
       // });
        // adjust image positioning so it lines up with video
        $bigImage
            .css('position', 'relative')
            .imagesLoaded(adjustImagePositioning);
        // and on window resize
        $window.on('resize', adjustImagePositioning)
    }

    adjustContainer();
    $window.on('resize', adjustContainer);

    // Previous button click goes to previous div
    $('#previous-btn').on('click', function (e) {
        e.preventDefault();
        if (!isTransitioning) {
            previous();
        }
    });

    // Next button click goes to next div
    $('#next-btn').on('click', function (e) {
        e.preventDefault();
        if (!isTransitioning) {
            next();
        }
    });

    // init fullscreen video
//    $('.fitvid').fitVids();

    // slide to hero screen on menu tab click
    $('#screen-menu .menu-tab').on('click', function (e) {
        e.preventDefault();
        if (!isTransitioning && (screenIndex != $(this).index() + 1)) {
            isTransitioning = true;

            screenIndex = $(this).index() + 1;

            selectedTab();
            if (!isTouch) {
                $('#big-video-wrap').transit({'left': '-100%'}, transitionDur)
            }

            (Modernizr.csstransitions) ?
                $('.video-wrapper').transit(
                    {'left': '-' + (100 * (screenIndex - 1)) + '%'},
                    transitionDur,
                    onTransitionComplete) :
                onTransitionComplete();
        }
    });

    // switch to new video
    function showVideo() {

        if(BV) {
            BV.pause();
        }

        BV = document.body.querySelector('#screen-' + screenIndex + ' video');

        if(BV) {
            var img = $('#screen-' + screenIndex + ' .big-image');
            BV.play();
            img.fadeOut();
        }

    }

    function previous() {
        isTransitioning = true;

        // update video index, reset image opacity if starting over
        if (screenIndex <= 1) {
            //$bigImage.css('opacity',1);
            screenIndex = numScreens;
        } else {
            screenIndex--;
        }

        selectedTab();

        if (!isTouch) {
            $('#big-video-wrap').transit({'left': '100%'}, transitionDur)
        }

        (Modernizr.csstransitions) ?
            $('.video-wrapper').transit(
                {'left': '-' + (100 * (screenIndex - 1)) + '%'},
                transitionDur,
                onTransitionComplete) :
            onTransitionComplete();
    }

    function next() {
        isTransitioning = true;

        // update video index, reset image opacity if starting over
        if (screenIndex === numScreens) {
            $bigImage.css('opacity', 1);
            screenIndex = 1;
        } else {
            screenIndex++;
        }

        selectedTab();

        if (!isTouch) {
            $('#big-video-wrap').transit({'left': '-100%'}, transitionDur)
        }

        (Modernizr.csstransitions) ?
            $('.video-wrapper').transit(
                {'left': '-' + (100 * (screenIndex - 1)) + '%'},
                transitionDur,
                onTransitionComplete) :
            onTransitionComplete();
    }

    function onTransitionComplete() {
        isTransitioning = false;
        if (!isTouch) {
            $('#big-video-wrap').css('left', 0);
            showVideo();
        }
    }

    function adjustContainer() {
        var windowHeight = $window.height();
        $('.video-wrapper').css('height', windowHeight + 'px');
    }

    function adjustImagePositioning() {
        $bigImage.each(function () {
            var $img = $(this),
                img = new Image();

            img.src = $img.attr('src');

            var windowWidth = $window.width(),
                windowHeight = $window.height(),
                r_w = windowHeight / windowWidth,
                i_w = img.width,
                i_h = img.height,
                r_i = i_h / i_w,
                new_w, new_h, new_left, new_top;

            if (r_w > r_i) {
                new_h = windowHeight;
                new_w = windowHeight / r_i;
            }
            else {
                new_h = windowWidth * r_i;
                new_w = windowWidth;
            }

            $img.css({
                width: new_w,
                height: new_h,
                left: ( windowWidth - new_w ) / 2,
                top: ( windowHeight - new_h ) / 2
            })

        });

    }

    // managing content selection on the about hero screen
    $('#section-camp').fadeIn();
    $('#screen-2 li').on('click', function() {
        var $this = $(this);
        if(!$this.hasClass('selected')) {
            var section = $this.attr('id').substring(5);

            $('#screen-2 .about-link').removeClass('selected');
            $this.addClass('selected');

            $('#screen-2 .about-section').removeClass('selected').fadeOut(100);
            $('#section-' + section).addClass('selected').delay(100).fadeIn(300);
        }
    });

    // top menu ScrollTo functionality
    $('#top-menu .menu-link, .screen .scroll-link').on('click', function (e) {
        if (this.hash !== "") {
            // Prevent default anchor click behavior
            event.preventDefault();

            // Store hash
            var hash = this.hash;

            // Using jQuery's animate() method to add smooth page scroll
            // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
            $('html, body').animate({
                scrollTop: $(hash).offset().top
            }, 800, function(){

                // Add hash (#) to URL when done scrolling (default click behavior)
                window.location.hash = hash;
            });
        } // End if
    });

    // logo scroll to top
    $('#top-menu .menu-logo').on('click', function(e) {
        $('html,body').animate({scrollTop: 0}, 600);
    });

    $('#top-menu .menu-tab a').on('click', scrollTab);

    // change highlight in menu based on position
    scrollTab();
    function scrollTab() {
        var $window = $(window);
        var $categories = $('.category');
        var scrollPosition = $window.scrollTop();
        var menuTab = 'menu-logo';

        $.each($categories, function () {
            var $this = $(this);
            var sectionId = $this.attr('id');

            if ((scrollPosition >= ($this.offset().top - 20))
                && (scrollPosition < $this.next().offset().top)) {
                menuTab = sectionId;
            }

            $('#top-menu .menu-tab').removeClass('selected');
            $('#top-menu .' + menuTab).parent().addClass('selected');
        });
    }

    $(window).on('scroll', scrollTab);

    // change highlight on screen menu based on slide screenIndex
    function selectedTab() {
        var menuTabs = $('.menu .menu-tab');
        menuTabs.removeClass('selected');

        menuTabs.eq(screenIndex - 1).addClass('selected');
    }

    // attach and detach the top nav bar based on position
    navLock();
    $(window).scroll(function () {
        navLock();
    });

    function navLock() {
        var $window = $(window);
        var nav = $('#top-menu');
        if ($window.scrollTop() >= $window.height()) {
            nav.addClass('locked');
        } else {
            if (nav.hasClass('locked')) {
                nav.removeClass('locked');
            }
        }
    }

    // 'zoom' the map on image hover
    $('.map-image').hover(function() {
        mapSwitch();
    }, function() {
        mapSwitch();
    });

    var mapSwitch = function(source) {
        var $this = $('.map-image');

        $this.stop().fadeOut(150);
        setTimeout( function(){
            $this.toggleClass('zoom-dadaab').fadeIn(150);
        }, 150);
    };

    // open and close the full credits
    var $creditContainer = $('.credit-container');

    $('.credits .heading').on('click', function() {
        $creditContainer.slideToggle(600).toggleClass('open');
    });

    // ScrollTo specific credit on link click
$('.credit-listing a').on('click', function() {
        var $this = $(this);
        var anchor = $this.attr('href');

        if(!$creditContainer.hasClass('open')) {
            $creditContainer.slideToggle(600).toggleClass('open');

            // wait for container to complete animation so ScrollTo finds an accurate position
            setTimeout( function(){
                $(anchor).ScrollTo({
                    duration: 600,
                    easing: 'swing',
                    offsetTop: 120
                });
            }, 600);

        } else {
            $(anchor).ScrollTo({
                duration: 600,
                easing: 'swing',
                offsetTop: 120
            });
        }

        return false;
    });
});
