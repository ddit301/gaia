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
                <h1 class="module-title font-alt">회원정보</h1>
              </div>
            </div>
            <hr class="divider-w pt-20">
            <div class="row">
              <div class="col-sm-12">
                <table id="member-table" class="table table-striped table-border checkout-table">
                  <thead>
                    <tr class="navbar-custom">
                      <th><i class="fa fa-check-square-o"></i></th>
<!--                       <th class="dropdown"> -->
<!--                       	<a class="dropdown-toggle" href="#" data-toggle="dropdown">ICON</a> -->
<!--                       	<ul class="dropdown-menu"> -->
<!--                       		<li><input type="checkbox">1 li</li> -->
<!--                       		<li><input type="checkbox">2 li</li> -->
<!--                       	</ul> -->
<!--                       </th> -->
                      <th>ICON</th>
                      <th>SID</th>
                      <th>EMAIL ID</th>
                      <th>닉네임</th>
                      <th>가입일</th>
                      <th>탈퇴일</th>
                    </tr>
                    </thead>
                    <tbody>
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
                        <td>00.00</td>
                      </tr>
                      <tr>
                        <th>Shipping Total :</th>
                        <td>89.00</td>
                      </tr>
                      <tr class="shop-Cart-totalprice">
                        <th>Total :</th>
                        <td>42.00</td>
                      </tr>
                    </tbody>
                  </table>
                  <button class="btn btn-lg btn-block btn-round btn-d" type="submit">Proceed to Checkout</button>
                </div>
              </div>
            </div>
          </div>
        </section>
	      </div>
    <!--  
    JavaScripts
    =============================================
    -->
<!--     <script defer src="/gaia/resources/main/lib/jquery/dist/jquery.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/bootstrap/dist/js/bootstrap.min.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/wow/dist/wow.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/isotope/dist/isotope.pkgd.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/imagesloaded/imagesloaded.pkgd.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/flexslider/jquery.flexslider.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/owl.carousel/dist/owl.carousel.min.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/smoothscroll.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/magnific-popup/dist/jquery.magnific-popup.js"></script> -->
<!--     <script defer src="/gaia/resources/main/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script> -->
<!--     <script defer src="/gaia/resources/main/js/plugins.js"></script> -->
<!--     <script defer src="/gaia/resources/main/js/main.js"></script> -->
<!--     <script defer type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script> -->
<!--     <script async type="text/javascript"> -->
// 	    $(document).ready( function () {
// 	    	function Employee ( name, position, salary, office, a, b ) {
// 	    	    this.name = name;
// 	    	    this.position = position;
// 	    	    this.salary = salary;
// 	    	    this._office = office;
// 	    	    this.a = a;
// 	    	    this.b = b;
	    	 
// 	    	    this.office = function () {
// 	    	        return this._office;
// 	    	    }
// 	    	};
	    	
// 	        $('.checkout-table').DataTable({
// 	        	data: [
// 	                new Employee( "Tiger Nixon", "System Architect", "$3,120", "Edinburgh" , "Edinburgh" , "Edinburgh" ),
// 	                new Employee( "Garrett Winters", "Director", "$5,300", "Edinburgh", "Edinburgh" , "Edinburgh"  )
// 	            ],
// 	        	columns: [
//         	        { data: 'MEM_NO' },
//         	        { data: 'MEM_ID' },
//         	        { data: 'MEM_NICK' },
//         	        { data: 'MEM_SIGN_DATE' },
//         	        { data: 'MEM_QUIT_DATE' }
//         	    ]
// 	        });
// 	    } );
<!--     </script> -->
