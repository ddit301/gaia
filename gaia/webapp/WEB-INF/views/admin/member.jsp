<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <div class="main">
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h1 class="module-title font-alt">Checkout</h1>
              </div>
            </div>
            <hr class="divider-w pt-20">
            <div class="row">
              <div class="col-sm-12">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr class="navbar-custom">
                      <th><i class="fa fa-check-square-o"></i></th>
                      <th  class="dropdown">
                      	<a class="dropdown-toggle" href="#" data-toggle="dropdown">ICON</a>
                      	<ul class="dropdown-menu">
                      		<li>1 li</li>
                      		<li>2 li</li>
                      	</ul>
                      
                      
                      
                      </th>
                      <th>SID</th>
                      <th>가입일</th>
                      <th>상태</th>
                      <th>Total</th>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>
<!--                         <a href="#"><img src="main/images/shop/product-14.jpg" alt="Accessories Pack"/></a> -->
 						<h5 class="product-title font-alt">123456789</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">2019.05.02</h5>
                      </td>
                      <td>
                        <input class="form-control" type="number" name="" value="1" max="50" min="1"/>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">2019.05.09</h5>
                      </td>
                      <td class="pr-remove"><a href="#" title="Remove"><i class="fa fa-times"></i></a></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>
<!--                         <a href="#"><img src="main/images/shop/product-14.jpg" alt="Accessories Pack"/></a> -->
 						<h5 class="product-title font-alt">123456789</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">2019.05.02</h5>
                      </td>
                      <td>
                        <input class="form-control" type="number" name="" value="1" max="50" min="1"/>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">2019.05.09</h5>
                      </td>
                      <td class="pr-remove"><a href="#" title="Remove"><i class="fa fa-times"></i></a></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-3">
                <div class="form-group">
                  <input class="form-control" type="text" id="" name="" placeholder="Coupon code"/>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="form-group">
                  <button class="btn btn-round btn-g" type="submit">Apply</button>
                </div>
              </div>
              <div class="col-sm-3 col-sm-offset-3">
                <div class="form-group">
                  <button class="btn btn-block btn-round btn-d pull-right" type="submit">Update Cart</button>
                </div>
              </div>
            </div>
            <hr class="divider-w">
            <div class="row mt-70">
              <div class="col-sm-5 col-sm-offset-7">
                <div class="shop-Cart-totalbox">
                  <h4 class="font-alt">Cart Totals</h4>
                  <table class="table table-striped table-border checkout-table">
                    <tbody>
                      <tr>
                        <th>Cart Subtotal :</th>
                        <td>Â£40.00</td>
                      </tr>
                      <tr>
                        <th>Shipping Total :</th>
                        <td>Â£2.00</td>
                      </tr>
                      <tr class="shop-Cart-totalprice">
                        <th>Total :</th>
                        <td>Â£42.00</td>
                      </tr>
                    </tbody>
                  </table>
                  <button class="btn btn-lg btn-block btn-round btn-d" type="submit">Proceed to Checkout</button>
                </div>
              </div>
            </div>
          </div>
        </section>
        <div class="module-small bg-dark">
          <div class="container">
            <div class="row">
              <div class="col-sm-3">
                <div class="widget">
                  <h5 class="widget-title font-alt">About Titan</h5>
                  <p>The languages only differ in their grammar, their pronunciation and their most common words.</p>
                  <p>Phone: +1 234 567 89 10</p>Fax: +1 234 567 89 10
                  <p>Email:<a href="#">somecompany@example.com</a></p>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="widget">
                  <h5 class="widget-title font-alt">Recent Comments</h5>
                  <ul class="icon-list">
                    <li>Maria on <a href="#">Designer Desk Essentials</a></li>
                    <li>John on <a href="#">Realistic Business Card Mockup</a></li>
                    <li>Andy on <a href="#">Eco bag Mockup</a></li>
                    <li>Jack on <a href="#">Bottle Mockup</a></li>
                    <li>Mark on <a href="#">Our trip to the Alps</a></li>
                  </ul>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="widget">
                  <h5 class="widget-title font-alt">Blog Categories</h5>
                  <ul class="icon-list">
                    <li><a href="#">Photography - 7</a></li>
                    <li><a href="#">Web Design - 3</a></li>
                    <li><a href="#">Illustration - 12</a></li>
                    <li><a href="#">Marketing - 1</a></li>
                    <li><a href="#">Wordpress - 16</a></li>
                  </ul>
                </div>
              </div>
              <div class="col-sm-3">
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
                <p class="copyright font-alt">&copy; 2017&nbsp;<a href="index.html">TitaN</a>, All Rights Reserved</p>
              </div>
              <div class="col-sm-6">
                <div class="footer-social-links"><a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-dribbble"></i></a><a href="#"><i class="fa fa-skype"></i></a>
                </div>
              </div>
            </div>
          </div>
        </footer>
      </div>
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
