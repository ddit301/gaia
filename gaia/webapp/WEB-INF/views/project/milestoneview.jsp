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
					<div class="milestoneviewBox">	
						<div class = "row">
							<div class ="milest-status col-md-1">
								<span class="label label-success">Open</span>
							</div>
							<div class="milestoneview-title col-md-5">
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
					
					
		
				<div class="milestoneview-header row">
				
					<div id="milestone-issue-chk" class="col-md-5">
	            		<button type="button" class="status-btn btn mb-1 btn-sm btn-flat btn-success">All</button>
	            		<button data-status="0" type="button" class="status-btn btn mb-1 btn-sm btn-flat btn-light">Open</button>
	            		<button data-status="1" type="button" class="status-btn btn mb-1 btn-sm btn-flat btn-light">Closed</button>
            		</div>
           			<div class="col-md-1"></div>
				
<!-- 						<div class="milestone-dropdown-btn"> -->
					<div class="dropdown-btn col-md-1">	
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">정렬</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">최신순</a> 
							<a class="dropdown-item" href="#">오래된순</a> 
							<a class="dropdown-item" href="#">댓글많은순</a>
						</div>
					</div>
				
					<div class="dropdown-btn col-md-1">	
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">담당자</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">Shane</a> 
							<a class="dropdown-item" href="#">Robin</a> 
							<a class="dropdown-item" href="#">Eisen</a>
						</div>
					</div>
					
					<div class="dropdown-btn col-md-1" >	
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">중요도</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">무시</a> 
							<a class="dropdown-item" href="#">낮음</a> 
							<a class="dropdown-item" href="#">보통</a>
						</div>
					</div>	

					<div class="dropdown-btn col-md-1">	
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">라벨</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">버그</a> 
							<a class="dropdown-item" href="#">문서</a> 
							<a class="dropdown-item" href="#">처리완료</a>
						</div>
					</div>
					
					
					<div class="dropdown-btn col-md-1">				
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">작성자</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">Shane</a> 
							<a class="dropdown-item" href="#">Robin</a> 
							<a class="dropdown-item" href="#">Eisen</a>
						</div>
					</div>
						<div class="col-md-1"></div>
<!-- 						</div> -->
				</div> 
			
				<div id="milestone-issuelist"></div>
           		<div class="milestoneview-footer"></div>
	           			

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
				
//             	milest_status = null;
            	
            	issue_status = null;
            	milestObject = null;
            	
				var open_count = 0;
				var total_count = 0;
				var comment_count = 0;
            	
// 				console.log(issue_status);
				milestoneissuelist = function(issue_status){
					let data = {}
					if(issue_status || issue_status == 0){
						data.issue_status = issue_status
						
					}
			            $.ajax({
							url : getContextPath() + '/restapi/project/milestones/'+milest_no
							,type : 'get'
							,data : data
							
							,success : function(res) {
								
							
														
								$('#milestone-issuelist').empty();
								
								milestObject = res;
								
								console.log(res.milest_status);
								// 마일스톤이 닫혀있는 경우 close 버튼으로 변경해둔다.
								if(res.milest_status == 1) {
									$('.milest-status').children('span').text('Closed');
									$('.milest-status').children('span').removeClass('label-success');
									$('.milest-status').children('span').addClass('label-danger');
									$('#close-milest-btn').text('Reopen milestone');
									$('#close-milest-btn').removeClass('btn-warning');
									$('#close-milest-btn').addClass('btn-primary');
								}
								
								
								$('.milestoneview-title').children('span').text(res.milest_title + ' #' + res.milest_no);
								$('.milest-title').children('span').text(res.milest_title);
								$('.milestoneview-date').children('span').text((res.milest_start_date == null ? "시작일 없음." : res.milest_start_date) +' - '+(res.milest_end_date == null ? "종료일 없음." : res.milest_end_date));
								$('.milestone-descript').children('span').text(res.milest_cont);
			            		$('.progress-bar').attr('style','width: '+res.milest_percent+'%;');
			            		$('.milestoneview-percent').children('span').text((res.milest_percent == null ? 0 : res.milest_percent)+'% complete '+res.open_issue_cnt+' open '+res.close_issue_cnt+' closed');
								
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
									issueBox.children('.issue-assignee').children('img').attr('src',getContextPath()+'/resources/assets/images/user/1.png');
									issueBox.children('.issue-writer').children('img').attr('src',getContextPath()+'/resources/assets/images/user/1.png');
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
					
				}
				
				// 페이지 로딩시 리스트 뽑기
				milestoneissuelist ();
				
				// 마일스톤 이슈 all / open /closed 버튼
				$(function(){
				
				$('#milestone-issue-chk').on('click','.status-btn', function(){
					
	            		$('#milestone-issue-chk').children('button').removeClass('btn-success');
	            		$('#milestone-issue-chk').children('button').addClass('btn-light');
	            		$(this).removeClass("btn-light");
	            		$(this).addClass("btn-success");
	            		
	            		let issue_status = $(this).data('status');
	            		window.scrollTo({top:0, left:0, behavior:'auto'});
	            		milestoneissuelist(issue_status);
	            	});
				
				})

				// 마일스톤 수정 버튼 클릭 시 
				$('.edit-milestone-btn').on('click',function(){

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
				
				// 마일스톤 수정 취소 버튼 클릭 시 
				$('#milest-edit-close-btn').on('click',function(){
          			milestoneView(milestObject.milest_no);
          		})
	          		
				
           
            
            $(function(){
            	// 모달창에서 마일스톤 삭제 버튼 클릭 시	 
				$('#delete-milest-btn').on('click',function(){
					
					$.ajax({
						url : getContextPath() + '/restapi/project/milestones',
						type : 'post',
						data : {
								'_method' : "delete"
								, 'milest_sid' : milestObject.milest_sid
							
						},
						success : function(res) {
							$('.modal-backdrop').removeClass('show').css("display","none");
							swal.success();
							movePageHistory("milestone");
							
						},
						error : function(xhr, error, msg) {
							console.log(xhr);
							console.log(error);
							console.log(msg);
						},
						dataType : 'json'
						,async : false
					})
				
          		})
          		
            })
            
            // milestone open / close 이벤트
            	 $(function(){
					 $('#close-milest-btn').on('click',function(){
						
						  milestObject.milest_status = milestObject.milest_status == 0 ? 1 : 0;
						 
						$.ajax({
							url : getContextPath() + '/restapi/project/milestones',
							type : 'post',
							data : {
								'_method' : 'put'
								,'milest_sid' : milestObject.milest_sid
								,'milest_status' : milestObject.milest_status
								,'milest_title' : milestObject.milest_title
					            ,'milest_start_date' : milestObject.milest_start_date
					            ,'milest_end_date' : milestObject.milest_end_date
					            ,'milest_cont' : milestObject.milest_cont
							},
							success : function(res) {
								// open milestone 인 경우
								if(milestObject.milest_status == 0) {
									//상위 라벨
									$('.milest-status').children('span').text('Open');
									$('.milest-status').children('span').removeClass('label-danger');
									$('.milest-status').children('span').addClass('label-success');
									//바닥 버튼
									$('#close-milest-btn').text('Close milestone');
									$('#close-milest-btn').removeClass('btn-primary');
									$('#close-milest-btn').addClass('btn-warning');
									// toastr 알람
									toastr.success('Milestone을 Open 했습니다.')
								// close milestone 인 경우	
								}else{
									//상위 라벨
									$('.milest-status').children('span').text('Closed');
									$('.milest-status').children('span').removeClass('label-success');
									$('.milest-status').children('span').addClass('label-danger');
									// 바닥 버튼 
									$('#close-milest-btn').text('Reopen milestone');
									$('#close-milest-btn').removeClass('btn-warning');
									$('#close-milest-btn').addClass('btn-primary');
									// toastr 알람
									toastr.options = {
										  "closeButton": false,
										  "debug": false,
										  "newestOnTop": false,
										  "progressBar": false,
										  "positionClass": "toast-top-right",
										  "preventDuplicates": false,
										  "onclick": null,
										  "showDuration": "100",
										  "hideDuration": "1000",
										  "timeOut": "1000",
										  "extendedTimeOut": "1000",
										  "showEasing": "swing",
										  "hideEasing": "linear",
										  "showMethod": "fadeIn",
										  "hideMethod": "fadeOut"
										}
									toastr.warning('Milestone을 Close 했습니다.')
								}
							},
							error : function(xhr, error, msg) {
								console.log(xhr);
								console.log(error);
								console.log(msg);
							},
							dataType : 'json'
						})
				
					 })	
				 })

			</script>
            
            
            
            
          
		