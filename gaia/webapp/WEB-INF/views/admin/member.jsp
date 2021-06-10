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
                <table id="member-table" class="table table-striped ">
                  <thead>
                    <tr class="navbar-custom">
                      <th><i class="fa fa-check-square-o"></i></th>
                      <th>ICON</th>
                      <th>SID</th>
                      <th>EMAIL ID</th>
                      <th>닉네임</th>
                      <th>가입일</th>
                      <th>탈퇴일</th>
                    </tr>
                  </thead>
                  <tbody>
                    
                  </tbody>
                </table>
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
    	
	    function asyncMovePage(url){
	        // ajax option
	        let ajaxOption = {
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
	    
	    function getMember(){
        console.log();
	    	$.ajax({
	    		url : getContextPath()+"/admin/member/ListView" ,
	    		type : 'get',
	    		success : function(res) {
	    			let data = res
            console.log(data);
	    			$('#member-table').DataTable({
              data : data,
              columns: [
                  { data: 'mem_status' },
                  { data: 'mem_pic_file_name' },
                  { data: 'mem_no' },
                  { data: 'mem_id' },
                  { data: 'mem_nick' },
                  { data: 'mem_sign_date' },
                  { data: 'mem_quit_date' }
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
      getMember();
    
    });
    </script>
