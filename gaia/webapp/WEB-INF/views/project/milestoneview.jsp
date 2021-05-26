<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/milestoneview.css" rel="stylesheet">
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
				<div class="milestoneview-btn">
					<a href="#" class="label label-info">New issue</a>
					<a href="#"	class="label label-info">Edit milestone</a>
				</div>
				<div id="milestoneview-template">
					<div class="milestoneviewBox">	
						<div class = "row">
							<div class="milestoneview-title col-md-6">
								<span></span>
				            </div>                                                                                     
							<div class="milestoneview-bar col-md-6">
								<div class="progress mb-3">
									<div class="progress-bar gradient-1" style=; role="progressbar">
									</div>	
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
					</div>
				</div>
					
		
				<div class="milestoneview-header">
					<div class="milestone-issue-chk col-md-4">
						<a class="btn mb-1 btn-sm btn-secondary" href="#">2 open</a>
						<a class="btn mb-1 btn-sm btn-secondary" href="#">0 closed</a>
					</div> 
					<div class="milestone-dropdown-btn col-md-8">
						<div class="dropdown-btn" style="float:right; padding-right:5px;">	
							<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">정렬</button>
							<div class="dropdown-menu" x-placement="bottom-start"
								style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
								<a class="dropdown-item" href="#">최신순</a> 
								<a class="dropdown-item" href="#">오래된순</a> 
								<a class="dropdown-item" href="#">댓글많은순</a>
							</div>
						</div>
					
						<div class="dropdown-btn" style="float:right; padding-right:5px;">	
							<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">담당자</button>
							<div class="dropdown-menu" x-placement="bottom-start"
								style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
								<a class="dropdown-item" href="#">Shane</a> 
								<a class="dropdown-item" href="#">Robin</a> 
								<a class="dropdown-item" href="#">Eisen</a>
							</div>
						</div>

						<div class="dropdown-btn" style="float:right; padding-right:5px;">	
							<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">라벨</button>
							<div class="dropdown-menu" x-placement="bottom-start"
								style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
								<a class="dropdown-item" href="#">버그</a> 
								<a class="dropdown-item" href="#">문서</a> 
								<a class="dropdown-item" href="#">처리완료</a>
							</div>
						</div>
						
						<div class="dropdown-btn" style="float:right; padding-right:5px;">	
							<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">중요도</button>
							<div class="dropdown-menu" x-placement="bottom-start"
								style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
								<a class="dropdown-item" href="#">무시</a> 
								<a class="dropdown-item" href="#">낮음</a> 
								<a class="dropdown-item" href="#">보통</a>
							</div>
						</div>	
						
						<div class="dropdown-btn" style="float:right; padding-right:5px;">				
							<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">작성자</button>
							<div class="dropdown-menu" x-placement="bottom-start"
								style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
								<a class="dropdown-item" href="#">Shane</a> 
								<a class="dropdown-item" href="#">Robin</a> 
								<a class="dropdown-item" href="#">Eisen</a>
							</div>
						</div>
					</div>
				</div> 
		
				<div id="milestone-issuelist"></div>
           		<div class="milestoneview-footer">
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
				

			<div id="milestone-issue-template" hidden="hidden" >
				<div class="issueBox row">                                                                                
					<div class="col-md-1"></div>                                                                    
					<div class="issue-title col-md-5">                                                              
						<a class="moveButton" data-menu="issueview" href="javascript:void(0)"></a>                                                       
					</div>  
					<div class="col-md-1"></div>                                                                                          
				    <div class="issue-writer col-md-1">                                                                  
						<img src="" alt="">      
					</div>                                                                                      
				    <div class="priority col-md-1"></div>                                                       
					<div class="issue-label col-md-1"></div>                                                           
					<div class="issue-assignee col-md-1">                                                                      
						<img src="" alt="">      
					</div>                                                                                      
					<div class="reply col-md-1">
						<i class="icon-bubbles icons"></i>
						<span></span>
					</div>                                                            
				</div>        
			</div>
            
            <script>
            	manager_nick = '${manager_nick }';
            	project_title = '${project_title }';
            	milest_no = '${milest_no}';
				var open_count = 0;
				var total_count = 0;
				
            	
	            $.ajax({
					url : getContextPath() + '/restapi/project/milestones/'+milest_no
					,type : 'get'
					,data : {
						'manager_nick' : manager_nick
						,'project_title' : project_title
					},
					success : function(res) {
						$('.milestoneview-title').children('span').text(res.milest_title + ' #' + res.milest_no);
						$('.milestoneview-date').children('span').text(res.milest_start_date+'~'+res.milest_end_date);
	            		$('.progress-bar').attr('style','width: '+res.milest_percent+'%;');
	            		$('.milestoneview-percent').children('span').text(res.milest_percent+'% complete 1 open 0 closed');
						
	            		total_count = Object.keys(res.issueList).length;
	            		
	            		
						$.each(issueList, function(i, v) {
							let issueBox = $('#milestone-issue-template').children('.issueBox').clone();
							issueBox.attr('issue_no',issueList.issue_no);
							issueBox.children('.issue-title').children('a').text(issueList.issue_title);
							issueBox.children('.priority').text('즉시');
							issueBox.children('.issue-label').text('할일');
							issueBox.children('.issue-assignee').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
							issueBox.children('.issue-writer').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
							issueBox.children('.reply').children('span').text('3');
							
							$('#milestone-issuelist').append(issueBox);
						})
						
					},
					error : function(xhr, error, msg) {
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'
				})
            </script>
            
            
            
            
            
          
		