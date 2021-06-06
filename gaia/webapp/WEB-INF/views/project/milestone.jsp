<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/milestone.css" rel="stylesheet"> 
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


	     		<div class="milestone-new-btn">
					<a class="moveButton label label-info" data-menu="newmilestone" href="javascript:void(0)">New milestone</a>
				</div>
		     	<div class="milestone-header row">
					<div class="milestone-chk row col-md-6">
						<button type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-success ">All</button>
		            	<button data-status="0" type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-light">Open</button>
		            	<button data-status="1" type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-light">Closed</button>
					</div>
		     	</div>
		     	<div id="milestone-list"></div>
		     	<div class="milestone-footer">
		     		<div>
	           			<ul class="pagination justify-content-center">
	                       <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">Previous</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">1</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">2</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">3</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">Next</a>
	                       </li>
	                   </ul>
           			</div>
		     	</div>
			</div>	
			
				<div id="milestone-template" hidden="hidden">
					<div class="milestoneBox">	
						<div class = "row">
							<div class="milestone-title col-md-6">
								<a class="milestoneButton" data-menu="milestoneview" href="javascript:void(0)"></a>    
				            </div>                                                                                     
							<div class="milestone-bar col-md-6">
								<div class="progress mb-3">
									<div class="progress-bar gradient-1" style=; role="progressbar">
									</div>	
								</div>
							</div>	                                                                                         
						</div>
						<div class = "row">
	                        <div class="milestone-date col-md-6">
								<span></span>                            
		                    </div>
		                    <div class="milestone-percent col-md-6">
		                        <span></span>
		                    </div>                               
						</div>
						<div class="row">
							<div class="milestone-descript col-md-6">
								<span></span>	
							</div>
<!-- 							<div class="milestone-status row col-md-6"> -->
<!-- 								<div class ="col-md-7"></div> -->
<!-- 								<button type="button" id="open-milest" class="milest-status-btn btn btn-sm btn-outline-secondary col-md-2">open</button> -->
<!--                                 <button type="button" id ="close-milest" class="milest-status-btn btn btn-sm btn-outline-danger col-md-2">close</button> -->
<!-- 							</div> -->
						</div>
					</div>     
				</div>
			
				
				 <script>
            	manager_nick = '${manager_nick }';
            	project_title = '${project_title }';
            	
            	
            	// milestonelist 을 불러오는 함수
            	milestonelist = function(milest_status){
            		
            		console.log(milest_status);
//             		let data = {}
//             		if(milest_status || milest_status == 0){
//             			data.milest_status = milest_status
            			
//             		}
            	
			            $.ajax({
							url : '${cPath}/restapi/project/milestones',
							type : 'get'
							,data :{
								'milest_status' : milest_status
							}
								
							,success : function(res) {
								
								$('#milestone-list').empty();
								
								$.each(res, function(i, v) {
									let milestoneBox = $('#milestone-template').children('.milestoneBox').clone();
									milestoneBox.attr('data-milest_no',v.milest_no);
									milestoneBox.find('.milestone-title').children('a').text(v.milest_title);
									milestoneBox.find('.milestone-descript').children('span').text(v.milest_cont);
									milestoneBox.find('.milestone-date').children('span').text((v.milest_start_date == null ? "시작일 없음." : v.milest_start_date) +' - '+(v.milest_end_date == null ? "종료일 없음." : v.milest_end_date));
									milestoneBox.find('.progress-bar').attr('style','width: '+v.milest_percent+'%;')
									milestoneBox.find('.milestone-percent').children('span').text((v.milest_percent == null ? 0 : v.milest_percent )+ '% complete '+(v.open_issue_cnt == null ? 0 : v.open_issue_cnt)+' open '+(v.close_issue_cnt == null ? 0 : v.close_issue_cnt)+' closed');
									
									$('#milestone-list').append(milestoneBox);
								})
								
							},
							error : function(xhr, error, msg) {
								if(xhr.status == 404){
									alert('해당하는 마일스톤 번호가 존재하지 않습니다. shane 에게 버그 report 해주세요.');
								}
								console.log(xhr);
								console.log(error);
								console.log(msg);
							},
							dataType : 'json'
						})
				
           			 }
            	
            	// 페이지 로딩시 마일스톤 리스트 뽑기 
            	milestonelist();
            	
            	
            	// 마일스톤 이슈 all / open /closed 버튼
				$(function(){
					
					// 특정 마일스톤 클릭시 불러오는 메서드
					$('#main-wrapper').on('click','.milestoneButton',function(){
						event.preventDefault();
						let milest_no = $(this).parents('.milestoneBox').data('milest_no');
						milestoneView(milest_no);
					})
				
				$('.status-btn').on('click', function(){
					
					$('.status-btn').removeClass('btn-success');
					$('.status-btn').addClass('btn-light');
	            		$(this).removeClass("btn-light");
	            		$(this).addClass("btn-success");
	            		
	            		let milest_status = $(this).data('status');
	            		window.scrollTo({top:0, left:0, behavior:'auto'});
	            		milestonelist(milest_status);
	            		
	            	});
				
				})
            </script>
            

		
			