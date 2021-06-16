<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
#typo-body {
  background: black;
  font-family: "Oswald", sans-serif;
  font-style: italic;
  height: 100vh;
}

.typo-container {
  position: absolute;
  transform: translate(-50%, -50%);
  top: 40%;
  left: 50%;
}
.glitch, .glow {
  color: #dfbfbf;
  position: relative;
  font-size: 9vw;
  animation: glitch 5s 5s infinite;
}
.glitch::before, .glow::before {
  content: attr(data-text);
  position: absolute;
  left: -2px;
  text-shadow: -5px 0 magenta;
  background: black;
  overflow: hidden;
  top: 0;
  animation: noise-1 3s linear infinite alternate-reverse, glitch 5s 5.05s infinite;
}
.glitch::after, .glow::after {
  content: attr(data-text);
  position: absolute;
  left: 2px;
  text-shadow: -5px 0 lightgreen;
  background: black;
  overflow: hidden;
  top: 0;
  animation: noise-2 3s linear infinite alternate-reverse, glitch 5s 5s infinite;
}
@keyframes glitch {
  1% {
    transform: rotateX(10deg) skewX(90deg);
  }
  2% {
    transform: rotateX(0deg) skewX(0deg);
  }
}
@keyframes noise-1 {
  3.3333333333% {
    clip-path: inset(57px 0 1px 0);
  }
  6.6666666667% {
    clip-path: inset(42px 0 33px 0);
  }
  10% {
    clip-path: inset(78px 0 5px 0);
  }
  13.3333333333% {
    clip-path: inset(55px 0 2px 0);
  }
  16.6666666667% {
    clip-path: inset(26px 0 8px 0);
  }
  20% {
    clip-path: inset(5px 0 59px 0);
  }
  23.3333333333% {
    clip-path: inset(43px 0 45px 0);
  }
  26.6666666667% {
    clip-path: inset(97px 0 4px 0);
  }
  30% {
    clip-path: inset(49px 0 32px 0);
  }
  33.3333333333% {
    clip-path: inset(27px 0 48px 0);
  }
  36.6666666667% {
    clip-path: inset(72px 0 28px 0);
  }
  40% {
    clip-path: inset(90px 0 4px 0);
  }
  43.3333333333% {
    clip-path: inset(36px 0 19px 0);
  }
  46.6666666667% {
    clip-path: inset(87px 0 10px 0);
  }
  50% {
    clip-path: inset(49px 0 21px 0);
  }
  53.3333333333% {
    clip-path: inset(76px 0 24px 0);
  }
  56.6666666667% {
    clip-path: inset(5px 0 53px 0);
  }
  60% {
    clip-path: inset(88px 0 6px 0);
  }
  63.3333333333% {
    clip-path: inset(25px 0 29px 0);
  }
  66.6666666667% {
    clip-path: inset(60px 0 31px 0);
  }
  70% {
    clip-path: inset(10px 0 27px 0);
  }
  73.3333333333% {
    clip-path: inset(38px 0 55px 0);
  }
  76.6666666667% {
    clip-path: inset(73px 0 7px 0);
  }
  80% {
    clip-path: inset(61px 0 20px 0);
  }
  83.3333333333% {
    clip-path: inset(22px 0 59px 0);
  }
  86.6666666667% {
    clip-path: inset(55px 0 45px 0);
  }
  90% {
    clip-path: inset(31px 0 65px 0);
  }
  93.3333333333% {
    clip-path: inset(98px 0 2px 0);
  }
  96.6666666667% {
    clip-path: inset(47px 0 51px 0);
  }
  100% {
    clip-path: inset(77px 0 18px 0);
  }
}
@keyframes noise-2 {
  0% {
    clip-path: inset(85px 0 13px 0);
  }
  3.3333333333% {
    clip-path: inset(8px 0 80px 0);
  }
  6.6666666667% {
    clip-path: inset(15px 0 6px 0);
  }
  10% {
    clip-path: inset(51px 0 20px 0);
  }
  13.3333333333% {
    clip-path: inset(93px 0 7px 0);
  }
  16.6666666667% {
    clip-path: inset(29px 0 46px 0);
  }
  20% {
    clip-path: inset(46px 0 49px 0);
  }
  23.3333333333% {
    clip-path: inset(88px 0 12px 0);
  }
  26.6666666667% {
    clip-path: inset(6px 0 95px 0);
  }
  30% {
    clip-path: inset(72px 0 6px 0);
  }
  33.3333333333% {
    clip-path: inset(88px 0 2px 0);
  }
  36.6666666667% {
    clip-path: inset(37px 0 54px 0);
  }
  40% {
    clip-path: inset(13px 0 67px 0);
  }
  43.3333333333% {
    clip-path: inset(15px 0 53px 0);
  }
  46.6666666667% {
    clip-path: inset(31px 0 18px 0);
  }
  50% {
    clip-path: inset(91px 0 5px 0);
  }
  53.3333333333% {
    clip-path: inset(31px 0 25px 0);
  }
  56.6666666667% {
    clip-path: inset(55px 0 42px 0);
  }
  60% {
    clip-path: inset(57px 0 7px 0);
  }
  63.3333333333% {
    clip-path: inset(18px 0 61px 0);
  }
  66.6666666667% {
    clip-path: inset(7px 0 53px 0);
  }
  70% {
    clip-path: inset(15px 0 35px 0);
  }
  73.3333333333% {
    clip-path: inset(62px 0 27px 0);
  }
  76.6666666667% {
    clip-path: inset(6px 0 44px 0);
  }
  80% {
    clip-path: inset(71px 0 22px 0);
  }
  83.3333333333% {
    clip-path: inset(37px 0 3px 0);
  }
  86.6666666667% {
    clip-path: inset(96px 0 5px 0);
  }
  90% {
    clip-path: inset(53px 0 44px 0);
  }
  93.3333333333% {
    clip-path: inset(32px 0 7px 0);
  }
  96.6666666667% {
    clip-path: inset(5px 0 52px 0);
  }
  100% {
    clip-path: inset(21px 0 31px 0);
  }
}
.scanlines {
  overflow: hidden;
  mix-blend-mode: difference;
}
.scanlines::before {
  content: "";
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  background: repeating-linear-gradient(to bottom, transparent 0%, rgba(255, 255, 255, 0.05) 0.5%, transparent 1%);
  animation: fudge 7s ease-in-out alternate infinite;
}
@keyframes fudge {
  from {
    transform: translate(0px, 0px);
  }
  to {
    transform: translate(0px, 2%);
  }
}
.glow {
  text-shadow: 0 0 1000px #dfbfbf;
  color: transparent;
  position: absolute;
  top: 0;
}
.subtitle {
  font-family: Arial, Helvetica, sans-serif;
  font-weight: 100;
  font-size: 0.8vw;
  color: rgba(165, 141, 141, 0.4);
  text-transform: uppercase;
  letter-spacing: 1em;
  text-align: center;
  position: absolute;
  width: 100vw;
  left: -202%;
  animation: glitch-2 5s 5.02s infinite;
}
@keyframes glitch-2 {
  1% {
    transform: rotateX(10deg) skewX(70deg);
  }
  2% {
    transform: rotateX(0deg) skewX(0deg);
  }
}
    
    
    
    </style>
      
      <div class="main">
        <section class="module" id="typo-body">
          
          
			      <div class="typo-container">
					  <div class="glitch" data-text="GAIA">GAIA</div>
					  <div class="glow">GAIA</div>
					  <p class="subtitle">Developer﹒Operator﹒</p>
				  </div>
				  <div class="scanlines">
				  </div>
          
          
          
          
          
          
        </section>
        
        
        
        <section class="home-section home-full-height bg-dark-30" id="home" data-background="resources/main/images/section-5.jpg">
        <div class="video-player" data-property="{videoURL:'https://www.youtube.com/watch?v=bNucJgetMjE', containment:'.home-section', startAt:18, mute:true, autoPlay:true, loop:true, opacity:1, showControls:false, showYTLogo:false, vol:25}"></div>
        <div class="video-controls-box">
          <div class="container">
            <div class="video-controls"><a class="fa fa-volume-up" id="video-volume" href="#">&nbsp;</a><a class="fa fa-pause" id="video-play" href="#">&nbsp;</a></div>
          </div>
        </div>
        <div class="titan-caption">
          <div class="caption-content">
            <div class="font-alt mb-30 titan-title-size-1">Hello &amp; welcome</div>
            <div class="font-alt mb-40 titan-title-size-4">We are SEED</div><a class="section-scroll btn btn-border-w btn-round" href="#about">Learn More</a>
          </div>
        </div>
      </section>
        
        
        
        
        
        
        <hr class="divider-w">
        <section class="module" id="team">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h2 class="module-title font-alt">Meet Our Team</h2>
                <div class="module-subtitle font-serif">A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.</div>
              </div>
            </div>
            <div class="row">
              <div class="mb-sm-20 wow fadeInUp col-sm-6 col-md-3" onclick="wow fadeInUp">
                <div class="team-item">
                  <div class="team-image"><img src="resources/main/images/team-1.jpg" alt="Member Photo"/>
                    <div class="team-detail">
                      <h5 class="font-alt">Hi all</h5>
                      <p class="font-serif">Lorem ipsum dolor sit amet, consectetur adipiscing elit lacus, a&amp;nbsp;iaculis diam.</p>
                      <div class="team-social"><a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-dribbble"></i></a><a href="#"><i class="fa fa-skype"></i></a></div>
                    </div>
                  </div>
                  <div class="team-descr font-alt">
                    <div class="team-name">Jim Stone</div>
                    <div class="team-role">Art Director</div>
                  </div>
                </div>
              </div>
              <div class="mb-sm-20 wow fadeInUp col-sm-6 col-md-3" onclick="wow fadeInUp">
                <div class="team-item">
                  <div class="team-image"><img src="resources/main/images/team-2.jpg" alt="Member Photo"/>
                    <div class="team-detail">
                      <h5 class="font-alt">Good day</h5>
                      <p class="font-serif">Lorem ipsum dolor sit amet, consectetur adipiscing elit lacus, a&amp;nbsp;iaculis diam.</p>
                      <div class="team-social"><a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-dribbble"></i></a><a href="#"><i class="fa fa-skype"></i></a></div>
                    </div>
                  </div>
                  <div class="team-descr font-alt">
                    <div class="team-name">Andy River</div>
                    <div class="team-role">Creative director</div>
                  </div>
                </div>
              </div>
              <div class="mb-sm-20 wow fadeInUp col-sm-6 col-md-3" onclick="wow fadeInUp">
                <div class="team-item">
                  <div class="team-image"><img src="resources/main/images/team-3.jpg" alt="Member Photo"/>
                    <div class="team-detail">
                      <h5 class="font-alt">Hello</h5>
                      <p class="font-serif">Lorem ipsum dolor sit amet, consectetur adipiscing elit lacus, a&amp;nbsp;iaculis diam.</p>
                      <div class="team-social"><a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-dribbble"></i></a><a href="#"><i class="fa fa-skype"></i></a></div>
                    </div>
                  </div>
                  <div class="team-descr font-alt">
                    <div class="team-name">Adele Snow</div>
                    <div class="team-role">Account manager</div>
                  </div>
                </div>
              </div>
              <div class="mb-sm-20 wow fadeInUp col-sm-6 col-md-3" onclick="wow fadeInUp">
                <div class="team-item">
                  <div class="team-image"><img src="resources/main/images/team-4.jpg" alt="Member Photo"/>
                    <div class="team-detail">
                      <h5 class="font-alt">Yes, it's me</h5>
                      <p class="font-serif">Lorem ipsum dolor sit amet, consectetur adipiscing elit lacus, a&amp;nbsp;iaculis diam.</p>
                      <div class="team-social"><a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-dribbble"></i></a><a href="#"><i class="fa fa-skype"></i></a></div>
                    </div>
                  </div>
                  <div class="team-descr font-alt">
                    <div class="team-name">Dylan Woods</div>
                    <div class="team-role">Developer</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="module bg-dark-60 pt-0 pb-0 parallax-bg testimonial" data-background="resources/main/images/testimonial_bg.jpg">
          <div class="testimonials-slider pt-140 pb-140">
            <ul class="slides">
              <li>
                <div class="container">
                  <div class="row">
                    <div class="col-sm-12">
                      <div class="module-icon"><span class="icon-quote"></span></div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-sm-8 col-sm-offset-2">
                      <blockquote class="testimonial-text font-alt">I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.</blockquote>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-sm-4 col-sm-offset-4">
                      <div class="testimonial-author">
                        <div class="testimonial-caption font-alt">
                          <div class="testimonial-title">Jack Woods</div>
                          <div class="testimonial-descr">SomeCompany INC, CEO</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
              <li>
                <div class="container">
                  <div class="row">
                    <div class="col-sm-12">
                      <div class="module-icon"><span class="icon-quote"></span></div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-sm-8 col-sm-offset-2">
                      <blockquote class="testimonial-text font-alt">I should be incapable of drawing a single stroke at the present moment; and yet I feel that I never was a greater artist than now.</blockquote>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-sm-4 col-sm-offset-4">
                      <div class="testimonial-author">
                        <div class="testimonial-caption font-alt">
                          <div class="testimonial-title">Jim Stone</div>
                          <div class="testimonial-descr">SomeCompany INC, CEO</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
              <li>
                <div class="container">
                  <div class="row">
                    <div class="col-sm-12">
                      <div class="module-icon"><span class="icon-quote"></span></div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-sm-8 col-sm-offset-2">
                      <blockquote class="testimonial-text font-alt">I am so happy, my dear friend, so absorbed in the exquisite sense of mere tranquil existence, that I neglect my talents.</blockquote>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-sm-4 col-sm-offset-4">
                      <div class="testimonial-author">
                        <div class="testimonial-caption font-alt">
                          <div class="testimonial-title">Adele Snow</div>
                          <div class="testimonial-descr">SomeCompany INC, CEO</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </section>
        <section class="module" id="news">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h2 class="module-title font-alt">Latest blog posts</h2>
                <div class="module-subtitle font-serif">A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.</div>
              </div>
            </div>
            <div class="row multi-columns-row post-columns">
              <div class="col-sm-6 col-md-4 col-lg-4">
                <div class="post mb-20">
                  <div class="post-thumbnail"><a href="#"><img src="resources/main/images/post-1.jpg" alt="Blog-post Thumbnail"/></a></div>
                  <div class="post-header font-alt">
                    <h2 class="post-title"><a href="#">Our trip to the Alps</a></h2>
                    <div class="post-meta">By&nbsp;<a href="#">Mark Stone</a>&nbsp;| 23 November | 3 Comments
                    </div>
                  </div>
                  <div class="post-entry">
                    <p>A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.</p>
                  </div>
                  <div class="post-more"><a class="more-link" href="#">Read more</a></div>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4">
                <div class="post mb-20">
                  <div class="post-thumbnail"><a href="#"><img src="resources/main/images/post-2.jpg" alt="Blog-post Thumbnail"/></a></div>
                  <div class="post-header font-alt">
                    <h2 class="post-title"><a href="#">Shore after the tide</a></h2>
                    <div class="post-meta">By&nbsp;<a href="#">Andy River</a>&nbsp;| 11 November | 4 Comments
                    </div>
                  </div>
                  <div class="post-entry">
                    <p>A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.</p>
                  </div>
                  <div class="post-more"><a class="more-link" href="#">Read more</a></div>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4">
                <div class="post mb-20">
                  <div class="post-thumbnail"><a href="#"><img src="resources/main/images/post-3.jpg" alt="Blog-post Thumbnail"/></a></div>
                  <div class="post-header font-alt">
                    <h2 class="post-title"><a href="#">We in New Zealand</a></h2>
                    <div class="post-meta">By&nbsp;<a href="#">Dylan Woods</a>&nbsp;| 5 November | 15 Comments
                    </div>
                  </div>
                  <div class="post-entry">
                    <p>A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.</p>
                  </div>
                  <div class="post-more"><a class="more-link" href="#">Read more</a></div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <div class="module-small bg-dark">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-md-6 col-lg-4 col-lg-offset-2">
                <div class="callout-text font-alt">
                  <h3 class="callout-title">Subscribe now</h3>
                  <p>We will not spam your email.</p>
                </div>
              </div>
              <div class="col-sm-6 col-md-6 col-lg-4">
                <div class="callout-btn-box">
                  <form id="subscription-form" role="form" method="post" action="php/subscribe.php">
                    <div class="input-group">
                      <input class="form-control" type="email" id="semail" name="semail" placeholder="Your Email" data-validation-required-message="Please enter your email address." required="required"/><span class="input-group-btn">
                        <button class="btn btn-g btn-round" id="subscription-form-submit" type="submit">Submit</button></span>
                    </div>
                  </form>
                  <div class="text-center" id="subscription-response"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <section class="module" id="contact">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h2 class="module-title font-alt">Get in touch</h2>
                <div class="module-subtitle font-serif"></div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <form id="contactForm" role="form" method="post" action="php/contact.php">
                  <div class="form-group">
                    <label class="sr-only" for="name">Name</label>
                    <input class="form-control" type="text" id="name" name="name" placeholder="Your Name*" required="required" data-validation-required-message="Please enter your name."/>
                    <p class="help-block text-danger"></p>
                  </div>
                  <div class="form-group">
                    <label class="sr-only" for="email">Email</label>
                    <input class="form-control" type="email" id="email" name="email" placeholder="Your Email*" required="required" data-validation-required-message="Please enter your email address."/>
                    <p class="help-block text-danger"></p>
                  </div>
                  <div class="form-group">
                    <textarea class="form-control" rows="7" id="message" name="message" placeholder="Your Message*" required="required" data-validation-required-message="Please enter your message."></textarea>
                    <p class="help-block text-danger"></p>
                  </div>
                  <div class="text-center">
                    <button class="btn btn-block btn-round btn-d" id="cfsubmit" type="submit">Submit</button>
                  </div>
                </form>
                <div class="ajax-response font-alt" id="contactFormResponse"></div>
              </div>
            </div>
          </div>
        </section>
        </div>
   