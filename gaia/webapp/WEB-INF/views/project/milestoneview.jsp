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
				<div class="milestoneview-btn">
					<a class="delete-milestone-btn label label-danger" data-menu="#" href="javascript:void(0)" >Delete milestone</a>
					
					<a class="edit-milestone-btn label label-info" data-menu="editmilestone" href="javascript:void(0)" >Edit milestone</a>
				</div>
				<div id="milestoneview-template">
				<div class="milestone-no" hidden = "hidden"></div>
					<div class="milestoneviewBox">	
						<div class = "row">
							<div class="milestoneview-title col-md-6">
								<span></span>
								<input type="text" hidden="hidden">
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
								<!--append date -->
								<div class="form-date-group row"></div>
								<!-- close append date -->
		                    
		                    <div class="milestoneview-percent col-md-6">
		                        <span></span>
		                        
		                        <!--  append button -->
		                       <div class="button" >
			                        <div class="save-changes-btn"></div>
			                        <div class="cancle-btn"></div>
		                        </div>  
		                        <!--  close append button -->
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
						<a class="open-btn mb-1 btn-sm btn-secondary" href="#"> open</a>
						<a class="close-btn mb-1 btn-sm btn-secondary" href="#">0 closed</a>
						<a class="all-btn mb-1 btn-sm btn-secondary" href="#">all</a>
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
				    <div class="issue-priority col-md-1"></div>                                                       
					<div class="issue-label col-md-1"></div>                                                           
					<div class="issue-assignee col-md-1">                                                                      
						<img src="" alt="">      
					</div>                                                                                      
					<div class="reply col-md-1">
					</div>                                                            
				</div>        
			</div>
            
            
            
            
            <script>
            	manager_nick = '${manager_nick }';
            	project_title = '${project_title }';
            	milest_no = '${milest_no}';
            	milestObject = null;
				var open_count = 0;
				var total_count = 0;
				var comment_count = 0;
				
            	
	            $.ajax({
					url : getContextPath() + '/restapi/project/milestones/'+milest_no
					,type : 'get'
					,data : {
						
					},
					success : function(res) {
						milestObject = res;
						$('.milestoneview-title').children('span').text(res.milest_title + ' #' + res.milest_no);
						$('.milestoneview-date').children('span').text(res.milest_start_date+'~'+res.milest_end_date);
						$('.milestone-descript').children('span').text(res.milest_cont);
	            		$('.progress-bar').attr('style','width: '+res.milest_percent+'%;');
	            		$('.milestoneview-percent').children('span').text(res.milest_percent+'% complete '+res.open_issue_cnt+' open '+res.close_issue_cnt+' closed');
						
	            		total_count = Object.keys(res.issueList).length;
	            		
						$.each(res.issueList, function(i, v) {
							let issueBox = $('#milestone-issue-template').children('.issueBox').clone();
							issueBox.attr('data-issue_no',v.issue_no);
							issueBox.children('.issue-title').children('a').text(v.issue_title);
							issueBox.children('.issue-priority').text(
									v.issue_priority == 1 ? '무시' :
									v.issue_priority == 2 ? '낮음' :
									v.issue_priority == 3 ? '보통' :
									v.issue_priority == 4 ? '높음' :
									v.issue_priority == 5 ? '긴급' : '즉시');
							
							if(v.label){
							issueBox.children('.issue-label').text(v.label.label_nm);								
							}
							issueBox.children('.issue-assignee').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
							issueBox.children('.issue-writer').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
							issueBox.children('.reply').children('span').text('3');
							if(v.replyCount > 0){
								issueBox.children('.reply').html(
										'<i class="icon-bubbles icons"></i><span>'+v.replyCount+'</span>'
									);
								
							}
							$('#milestone-issuelist').append(issueBox);
						})
						
					},
					error : function(xhr, error, msg) {
						// 조회중인 프로젝트 번호를 세션에서 못 받아 올 경우, 메인 홈페이지로 보낸다.
						if(xhr.status == 400){
							window.location.href = getContextPath();
						}
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'
				})
				
				</script>
				
				<script>
					
// 			// edit milestone
// 			var editmilestone = function(milest_no){
// 			let project_title = '${project_title}';
// 			let manager_nick = '${manager_nick}';
			
// 			data = 'editmilestone';
// 			title = '';
// 			url = '${cPath}/${manager_nick}/${project_title}/editmilestone/'+milest_no;
// 			history.pushState(data,title,url);
			
// 			$.ajax({
// 				url : '${cPath}/view/project/editmilestone'
// 				,type : 'get'
// 				,data : {
// 					'manager_nick' : manager_nick
// 					,'project_title' : project_title
// 					,'milest_no' : milest_no
// 					}
// 				,success : function(res) {
// 					$('.content-body').html(res);
// 				}
// 				,error : function(xhr){
// 					alert('error : ' + xhr.status);
// 				},
// 				dataType : 'html'
// 			})
// 			}
				
// 				$(function(){
// 					// 특정 마일스톤 수정시 데이터 값 넘기기
// 					$('#main-wrapper').on('click','.editMilestoneButton',function(){
						
// 						alert(milest_no);
						
// 					})
// 				}

				$('.edit-milestone-btn').on('click',function(){
// 					alert(milest_no);
// 					$('.milestoneview-title').children('span').attr('hidden','hidden');
// 					$('.milestoneview-title').children('input').removeAttr('hidden');
// 					$('.milestoneview-date').children('span').attr('hidden','hidden');
// 					$('.milestone-descript').children('span'C).attr('hidden','hidden');
// 					$('.milestoneview-bar').attr('hidden','hidden');
// 					$('.milestoneview-percent').children('span').attr('hidden','hidden');
					
// 					$('.delete-milestone-btn').attr('hidden','hidden');
// 					$('.edit-milestone-btn').attr('hidden','hidden');
					

					
					
// 					$('.save-changes-btn').append('<button class="save-changes-btn btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button"><i class="fa fa-check m-r-5"></i> save changes </button>');
// 					$('.cancle-btn').append(' <button class="cancle-btn btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20" type="button"><i class="ti-close m-r-5 f-s-12"></i> close </button>');


// 					$('.milestoneview-title').append('<label>Title : </label><input class="edit-milestone-title" type="text" placeholder="text" ></input>');
						$.ajax({
							url : '${cPath}/view/project/editmilestone'
							,type : 'get'
							,data : {
								'manager_nick' : manager_nick
								,'project_title' : project_title
								,'milest_no' : milest_no
								}
							,success : function(res) {
								$('.content-body').html(res);
							}
							,error : function(xhr){
								alert('error : ' + xhr.status);
							},
							dataType : 'html'
						})
				})
            </script>
            
            
            
            
            
          
		