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
		     	<div class="milestone-header">
					<div class="mileston-chk">
		     				<a class="btn mb-1 btn-sm btn-secondary" href="#">2 Open</a>
							<a class="btn mb-1 btn-sm btn-secondary" href="#">0 closed</a>
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
							<div class="col-md-6">
								<span></span>	
							</div>
						</div>
					</div>
				</div>
			
				
				 <script>
            	manager_nick = '${manager_nick }';
            	project_title = '${project_title }';
            	
	            $.ajax({
					url : '${cPath}/restapi/project/milestones',
					type : 'get',
					data : {
						//'manager_nick' : manager_nick
					},
					success : function(res) {
						
						$.each(res, function(i, v) {
							let milestoneBox = $('#milestone-template').children('.milestoneBox').clone();
							milestoneBox.attr('data-milest_no',v.milest_no);
							milestoneBox.find('.milestone-title').children('a').text(v.milest_title);
							milestoneBox.find('.milestone-descript').children('span').text(v.milest_cont);
							milestoneBox.find('.milestone-date').children('span').text(v.milest_start_date+'~'+v.milest_end_date);
							milestoneBox.find('.progress-bar').attr('style','width: '+v.milest_percent+'%;')
							milestoneBox.find('.milestone-percent').children('span').text(v.milest_percent+'% complete '+v.open_issue_cnt+' open '+v.close_issue_cnt+' closed');
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
            </script>
            

		
			