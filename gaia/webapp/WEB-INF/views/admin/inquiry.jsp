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
                <h1 class="module-title font-alt">문의내역</h1>
              </div>
            </div>
            <hr class="divider-w pt-20">
            <div class="row">
              <div class="col-sm-12">
                <table id="inquiry-table" class="table table-striped table-border checkout-table">
                  <thead>
                    <tr class="navbar-custom">
<!--                       <th><i class="fa fa-check-square-o"></i></th> -->
<!--                       <th class="dropdown"> -->
<!--                       	<a class="dropdown-toggle" href="#" data-toggle="dropdown">ICON</a> -->
<!--                       	<ul class="dropdown-menu"> -->
<!--                       		<li><input type="checkbox">1 li</li> -->
<!--                       		<li><input type="checkbox">2 li</li> -->
<!--                       	</ul> -->
<!--                       </th> -->
                      <th>INQ_NO</th>
                      <th>MEM_NO</th>
                      <th>INQ_CONT</th>
                      <th>INQ_DATE</th>
                      <th>INQ_STATUS_YN</th>
                      <th>ATCH_FILE_SID</th>
                    </tr>
                  </thead>
                  <tbody>
                    
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
	<script type="text/javascript">
    $(document).ready( function () {
    	
	   
	    function getInquiry(){
        console.log('getInquiry');
	    	$.ajax({
	    		url : getContextPath()+"/admin/inquiry/ListView" ,
	    		type : 'get',
	    		success : function(res) {
	    			let data = res
            console.log(data);
	    			$('#inquiry-table').DataTable({
              data : data,
              columns: [
                  { data: 'inq_no' },
                  { data: 'mem_no' },
                  { data: 'inq_cont' },
                  { data: 'inq_date' },
                  { data: 'inq_status_yn' },
                  { data: 'atch_file_sid' }
              ]
            });
	    		},
	    		async : true
	    		,error : function(xhr) {
	    			console.log(xhr);
	    			if(xhr.status == '404'){
	    				alert("실패");				
	    			}else{
	    				alert("status : " + xhr.status);
	    			}
	    		},
	    		dataType : 'json'
	    	})
	    }
	    getInquiry();
    
    });
    </script>
