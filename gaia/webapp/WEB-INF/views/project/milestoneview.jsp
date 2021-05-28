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
					<a class="label label-danger" data-menu="#" href="javascript:void(0)" >Delete milestone</a>
					<a class="label label-info" data-menu="#" href="javascript:void(0)" >New issue</a>
					<a class="moveButton label label-info" data-menu="editmilestone" href="javascript:void(0)" >Edit milestone</a>
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
					
		
				<div class="milestoneview-header">
					<div class="milestone-issue-chk col-md-4">
						<a class="btn mb-1 btn-sm btn-secondary" href="#">2 open</a>
						<a class="btn mb-1 btn-sm btn-secondary" href="#">0 closed</a>
						<a class="btn mb-1 btn-sm btn-secondary" href="#">all</a>
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
           			
           		</div>
           	</div>
				

			<div id="milestone-issue-template" hidden="hidden" >
				<div class="issueBox row">                                                                                
					<div class="col-md-1"></div>                                                                    
					<div class="issue-title col-md-5">                                                              
						<a class="issueButton" data-menu="issueview" href="javascript:void(0)"></a>                                                       
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
				var comment_count = 0;
				
            	
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
						$('.milestone-descript').children('span').text(res.milest_cont);
	            		$('.progress-bar').attr('style','width: '+res.milest_percent+'%;');
	            		$('.milestoneview-percent').children('span').text(res.milest_percent+'% complete '+res.open_issue_cnt+' open '+res.close_issue_cnt+' closed');
						
	            		total_count = Object.keys(res.issueList).length;
	            		
	            		
	            		console.log(total_count);
						$.each(res.issueList, function(i, v) {
							let issueBox = $('#milestone-issue-template').children('.issueBox').clone();
							issueBox.attr('data-issue_no',v.issue_no);
							issueBox.children('.issue-title').children('a').text(v.issue_title);
							issueBox.children('.priority').text(
									v.priority == 1 ? '무시' :
									v.priority == 2 ? '낮음' :
									v.priority == 3 ? '보통' :
									v.priority == 4 ? '높음' :
									v.priority == 5 ? '긴급' : '즉시');
							issueBox.children('.issue-label').text(v.label_nm);
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
            
            
            
            
            
          
		