<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 22 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/issue.css" rel="stylesheet">
    
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>
            
             <div class="container-fluid">
             	<div class="issue-title row">
            		<div class="namefield col-md-10">
	            		<span ></span>
            		</div>
            		<div class="col-md-2">
            			<i class="icon-note menu-icon"></i>
            		</div>
            	</div>
            	<div class="issue-body row">
            		<div class="col-md-9">
            			<div id="issue-body-cont">
            			</div>
           				<div class="repWrite issue-reply row">
		            		<div class="col-md-1">
		            			<img src="/gaia/resources/assets/images/user/2.png" alt="">
		            		</div>
		            		<div class="rep-right col-md-10">
            					<div class="repHeader">
		            				<button type="button" class="btn mb-1 btn-flat btn-dark">Write</button>
		            				<button type="button" class="btn mb-1 btn-flat btn-outline-light">Preview</button>
		            			</div>
		            			<div class="repBody">
		            				<textarea rows="4"></textarea>
		            			</div>
		            			<div class="repFoot">
		            				<button type="button" class="btn mb-1 btn-warning">Close issue</button>
		            				<button type="button" class="btn mb-1 btn-success">Comment</button>
		            			</div>
            				</div>
            			</div>
            		</div>
            		<div class="menulist col-md-3 row">
            			<div class="menuBox row">
	            			<div class="col-md-10">
		            			<p>담당자</p>
		            			<div id="assignees">
		            			</div>
	            			</div>
	           				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
	           				</div>
	           			</div>
           				<div class="menuBox row">
            				<div id="milestone" class="col-md-10">
		            			<p>마일스톤</p>
		            			<span></span>
            				</div>
            				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
            				</div>
            			</div>
            			<div class="menuBox row">
            				<div id="label" class="col-md-10">
		            			<p>라벨</p>
		            			<span></span>
            				</div>
            				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
            				</div>
            			</div>
            			<div class="menuBox row">
            				<div id="priority" class="col-md-10">
		            			<p>중요도</p>
		            			<span>즉시</span>
            				</div>
            				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
            				</div>
            			</div>
            		</div>
            	</div>
            </div>
 
 <div id="issue-template" hidden="hidden" >
 	<!--  이슈 담당자 시작-->
	<p>
		<img src="/gaia/resources/assets/images/user/1.png" alt="">
		<span></span>
	</p>
 	<!--  이슈 담당자 끝-->
	
	<!--  이슈 댓글 시작-->
	<div class="issue-reply row">
		<div class="col-md-1">
			<img src="/gaia/resources/assets/images/user/1.png" alt="">
		</div>
		<div class="rep-right col-md-10">
			<div class="repHeader">
				<span></span>
				<span>commented 8 days ago</span>
				<i class="icon-options menu-icon"></i>
			</div>
			<div class="repBody">
			</div>
		</div>
	</div>
	<!--  이슈 댓글 끝-->
	
	<!--  이슈 수정내역 시작-->
	<div class="issue-change row">
		<div class="col-md-1"></div>
		<div class="col-md-1">
			<i class="icon-note menu-icon"></i>
		</div>
		<div class="col-md-6">
			<img src="/gaia/resources/assets/images/user/1.png" alt="">
			<span></span>
		</div>
	</div>
	<!--  이슈 수정내역 끝-->
	
</div>
            
            <script>
            manager_nick = '${manager_nick}';
            project_title = '${project_title}';
            issue_no = '${issue_no}';
            	
	            $.ajax({
					url : getContextPath() + '/restapi/project/issues/'+issue_no,
					type : 'get',
					data : {
						'manager_nick' : manager_nick
						,'project_title' : project_title
					},
					success : function(res) {
						$('#assignees').empty();
						$('#issue-body-cont').empty();
						
						$('.namefield').children('span').text(res.issue_title + ' #' + res.issue_no);
						$('#milestone').children('span').text(res.milest_title);
						$('#label').children('span').text(res.label_nm);
						$('#priority').children('span').text(
								res.priority == 1 ? '무시' :
								res.priority == 2 ? '낮음' :
								res.priority == 3 ? '보통' :
								res.priority == 4 ? '높음' :
								res.priority == 5 ? '긴급' : '즉시'
							);
						$.each(res.assigneeList, function(i,v){
							let assigneeBox = $('#issue-template').children('p').clone();
							assigneeBox.children('span').text(v.mem_nick);
							$('#assignees').append(assigneeBox);
						})
						$.each(res.historyList, function(i,v){
							let issue_history;
							// 히스토리가 댓글일 경우와 댓글이 아닐 경우로 분기됩니다.
							if(v.issue_his_type == 'RE'){
								issue_history = $('#issue-template').children('.issue-reply').clone();
								issue_history.find('.repHeader').children('span:first').text(v.his_writer_nick);
								issue_history.find('.repBody').text(v.issue_his_cont);
							}else{
								issue_history = $('#issue-template').children('.issue-change').clone();
								issue_history.find('span').text(v.issue_his_cont);
							}
							$('#issue-body-cont').append(issue_history);
						})
					},
					error : function(xhr, error, msg) {
						if(xhr.status == 404){
							alert('해당하는 이슈 번호가 존재하지 않습니다. shane 에게 버그 report 해주세요.');
						}
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'
				})
             </script> 
            
            
            
            
            
            
            