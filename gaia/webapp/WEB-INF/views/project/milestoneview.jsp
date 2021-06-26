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
    	<div class="milest-container"> 
	            <!-- row -->
				<div class="milestoneview-btn">
				 <!-- Button trigger modal -->
					<a class="delete-milestone-btn label label-danger" data-toggle="modal" data-target="#basicModal" href="javascript:void(0)" >Delete milestone</a>
					<a class="edit-milestone-btn label label-info" data-menu="editmilestone" href="javascript:void(0)" >Edit milestone</a>
				</div>
				
				<div class="bootstrap-modal">
                            <!-- Modal -->
                    <div class="modal fade" id="basicModal" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Delete milestone</h5>
                                    <button type="button" class="close" data-dismiss="modal"><span>×</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                	<div class = "milest-title">
                                	[ <span></span> ] 을/를 삭제 하시겠습니까?
                                	</div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary " data-dismiss="modal">Close</button>
                                    <button type="button" id = "delete-milest-btn" class="btn btn-danger" data-dismiss="modal" >Delete milestone</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
				<div id="milestoneview-template">
					<div class="milestoneviewBox card">	
						<div class = "row">
							<div class ="milest-status col-md-2">
								<span class="label label-success">Open</span>
							</div>
							<div class="milestoneview-title col-md-4">
								<span></span>
				            </div>  
				                                                                                  
							<div class="milestoneview-bar col-md-6">
								<div class="progress mb-3">
									<div class="progress-bar gradient-1" style=; role="progressbar"></div>	
								</div>
							</div>	                                                                                         
						</div>
						<div class = "row">
	                        <div class="milestoneview-date col-md-6">
								<span></span>
							</div>	
		                    <div class="milestoneview-percent col-md-6">
		                        <span></span>
		                    </div>                               
						</div>
						<div class="row">
							<div class="milestone-descript col-md-6">
								<span></span>	
							</div>
							<div class="milestone-status row col-md-6">
								<div class ="col-md-8"></div>
<!-- 								<button type="button" id="open-milest" class="milest-status-btn btn btn-sm btn-outline-secondary col-md-2">open</button> -->
                                <button type="button" id ="close-milest-btn" class="milest-status-btn btn btn-sm btn-outline-danger col-md-3">close</button>
							</div>
						</div>
					</div>
				</div>
					
					
		
				<div class="milestoneview-header row card">
				
					<div id="milestone-issue-chk" class="col-md-5">
	            		<button type="button" class="status-btn btn mb-1 btn-sm btn-flat btn-success">All</button>
	            		<button data-status="0" type="button" class="status-btn btn mb-1 btn-sm btn-flat btn-light">Open</button>
	            		<button data-status="1" type="button" class="status-btn btn mb-1 btn-sm btn-flat btn-light">Closed</button>
            		</div>
           			<div class="col-md-1"></div>
				
					<div class="col-md-1">	
						<button class="btn btn-sm">작성자</button>
					</div>
					<div class="col-md-1">	
						<button class="btn btn-sm">중요도</button>
					</div>
					<div class="col-md-1">	
						<button class="btn btn-sm">라벨</button>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-1">	
						<button class="btn btn-sm">담당자</button>
					</div>
					<div class="col-md-1"></div>
				</div> 
			
				<div id="milestone-issuelist" class="card"></div>
           		<div class="milestoneview-footer"></div>

          </div>
				
		<!-- milestone-issue-template -->
			<div id="milestone-issue-template" hidden="hidden" >
				<div class="issueBox row">                                                                                
					<div class="iss-chkbox col-md-1">
						<input type = "checkbox">
					</div>                                                                    
					<div class="issue-title col-md-4">                                                              
						<a class="issueButton" data-menu="issueview" href="javascript:void(0)"></a>                                                       
					</div>  
					<div class="col-md-1"></div>                                                                                         
				    <div class="issue-writer col-md-1">                                                                  
						<img class="profile" onerror="imgOnErr()">  
					</div>                                                                                      
				    <div class="issue-priority col-md-1"></div>                                                       
					<div class="milest-issue-label col-md-1"></div>  
					<div class="col-md-1"></div>                                                           
					<div class="issue-assignee col-md-1">                                                                      
					</div>                                                                                      
					<div class="reply col-md-1">
					</div>                                                            
				</div>        
			</div>
	
            
<script>
	$(function(){
       	milest_no = getUrlParameter();

       	issue_status = null;
       	milestObject = null;
	         	
		var open_count = 0;
		var total_count = 0;
		var comment_count = 0;
		
		// 페이지 로딩시 리스트 뽑기
		milestoneissuelist ();
	});
</script>
            
            
            
          
		