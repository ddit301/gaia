<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/newmilestone.css" rel="stylesheet">
    	<div class="container"> 
	            <div class="row page-titles mx-0">
	                <div class="col p-md-0">
	                    <ol class="breadcrumb">
	                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
	                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
	                    </ol>
	                </div>
	            </div>
	            <!-- row -->
			
   
            
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="newmilestonebox">
                                    <div class="compose-content mt-5">                                  
	                                    <div class="milestonehead">
											  <div class="milestonehead-heading">Edit milestone</div>
										  <div class="milestonehead-description">edit your milestone</div>
										</div>
                                        <form action="#">
                                            <div class="form-title-group">
                                            	<div class="input-label">
									           		<label for="milestone_title">Title</label>
									          	</div>
									          		<div class="milestone-title">
                                                	<input type="text" class="form-control bg-transparent">
                                                	</div>
                                            </div>
                                            
											<div class="form-date-group row">
									  			<div class ="date-box">
									          		<div class="input-label">
									          			<label for="milestone_start_on">Start date (optional)</label>
									         		</div>
									      	 		<div class = "milest-start-date">
									            		<input type="date" pattern="\d\d\d\d-\d\d-\d\d" placeholder="yyyy-mm-dd" class="form-control" id="milest-start-date" name="mmilest-start-date">
									          		</div>
									          	</div>
									          	<div class ="date-box">
									          		<div class="input-label">
									          			<label for="milestone_due_on">Due date (optional)</label>
									         		</div>
									      	 		<div class="milest-end-date">
									            		<input type="date" pattern="\d\d\d\d-\d\d-\d\d" placeholder="yyyy-mm-dd" class="form-control" id="milest-end-date" name="milest-end-date">
									            	</div>
									          	</div>
											</div>
                                            <div class="form-text-group">
                                            	<div class="input-label">
									          		<label for="milestone_description">Description</label>
									         	</div>
                                                <textarea class="textarea_editor form-control bg-light" rows="1" placeholder="Enter text"></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="button m-t-15">
                                        <button id = "milest-changes-btn" class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button"><i class="fa fa-check m-r-5"></i> save changes</button>
                                        <button id  = "milest-edit-close-btn"class="btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20" type="button"><i class="ti-close m-r-5 f-s-12"></i> close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
          </div>
          
          <script>
          
          // 기존 입력 값 가져오기 
          $('.milestone-title').children('input').val(milestObject.milest_title);
          $('.milest-start-date').children('input').val(milestObject.milest_start_date);
          $('.milest-end-date').children('input').val(milestObject.milest_end_date);
          $('.form-text-group').children('textarea').val(milestObject.milest_cont);
          
          
          console.log(milestObject.milest_sid)
          	$(function(){
          		// 수정 버튼 클릭
          		$('#milest-changes-btn').on('click',function(){

				
				milest_title = $('.milestone-title').find('input').val();
				milest_start_date = $('.milest-start-date').children('input').val();
				milest_end_date = $('.milest-end-date').children('input').val();
				milest_cont = $('.form-text-group').children('textarea').val();
				milest_sid =  milestObject.milest_sid;
				
				$.ajax({
					url : getContextPath() + '/restapi/project/milestones',
					type : 'post',
					data : {
							'_method' : 'put'
							,'milest_sid' : milest_sid
			                ,'milest_title' : milest_title
			                ,'milest_start_date' : milest_start_date
			                ,'milest_end_date' : milest_end_date
			                ,'milest_cont' : milest_cont
			                
			            
						
					},
					success : function(res) {
						alert("success");
						milestoneView(milestObject.milest_no);
					},
					error : function(xhr, error, msg) {
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'
				})
			
          		})
          		
          		$('#milest-edit-close-btn').on('click',function(){
          			milestoneView(milestObject.milest_no);
          		})
          		
          		// datePicker 동작시키기
    		    $('.date-box').find('input').bootstrapMaterialDatePicker({
    		    	// 시간은 설정 안하고 날짜만 선택할 것
    		        time: false
    		        // 설정은 최소 오늘 이후의 날자만 가능
    		        ,minDate : new Date()
    		    });
    			
    			// startDate 가 정해 진 후에는 endDate는 그 이후로만 적용할 수 있도록 막기
    			$('.milest-start-date').children('input').on('change', function(){
    				let startDate = $('.milest-start-date').children('input').val();
    				$('.milest-end-date').children('input').bootstrapMaterialDatePicker("setMinDate", startDate);
    			})
    	
    			
 

          	})
		
          </script>
            
            
          
		