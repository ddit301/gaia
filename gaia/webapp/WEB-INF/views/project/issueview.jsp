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
	            		<span >유스케이스 정의서 작성하기 #412</span>
            		</div>
            		<div class="col-md-2">
            			<i class="icon-note menu-icon"></i>
            		</div>
            	</div>
            	<div class="issue-body row">
            		<div class="col-md-9">
            			<div class="issue-reply row">
		            		<div class="col-md-1">
		            			<img src="/gaia/resources/assets/images/user/1.png" alt="">
		            		</div>
		            		<div class="rep-right col-md-10">
            					<div class="repHeader">
		            				<span>Shane commented 8 days ago</span>
		            				<i class="icon-note menu-icon"></i>
		            			</div>
		            			<div class="repBody">
		            				유스 케이스 정의서 문서 작업 해주세요!<br>해줘요!!<br>빨리!!
		            			</div>
            				</div>
            			</div>
            			<div class="issue-reply row">
		            		<div class="col-md-1">
		            			<img src="/gaia/resources/assets/images/user/2.png" alt="">
		            		</div>
		            		<div class="rep-right col-md-10">
            					<div class="repHeader">
		            				<span>Shane commented 8 days ago</span>
		            				<i class="icon-note menu-icon"></i>
		            			</div>
		            			<div class="repBody">
		            				유스 케이스 정의서 문서 작업 해주세요!<br>해줘요!!<br>빨리!!
		            			</div>
            				</div>
            			</div>
            			<div class="issue-change row">
            				<div class="col-md-1"></div>
            				<div class="col-md-1">
            					<i class="icon-note menu-icon"></i>
            				</div>
            				<div class="col-md-6">
            					<img src="/gaia/resources/assets/images/user/1.png" alt="">
            					Shane Closed this 1 hour ago
            				</div>
            			</div>
            			<div class="issue-change row">
            				<div class="col-md-1"></div>
            				<div class="col-md-1">
            					<i class="icon-note menu-icon"></i>
            				</div>
            				<div class="col-md-6">
            					<img src="/gaia/resources/assets/images/user/1.png" alt="">
            					Shane 이 중요도를 급함 으로 변경함
            				</div>
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
		            			<p>
			            			<img src="/gaia/resources/assets/images/user/1.png" alt="">
			            			<span>Shane</span>
			            		</p>
		            			<p>
			            			<img src="/gaia/resources/assets/images/user/2.png" alt="">
			            			<span>Robin</span>
			            		</p>
	            			</div>
	           				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
	           				</div>
	           			</div>
           				<div class="menuBox row">
            				<div class="col-md-10">
		            			<p>마일스톤</p>
		            			<span>설계구현</span>
            				</div>
            				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
            				</div>
            			</div>
            			<div class="menuBox row">
            				<div class="col-md-10">
		            			<p>라벨</p>
		            			<span>할일</span>
            				</div>
            				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
            				</div>
            			</div>
            				<div class="menuBox row">
            				<div class="col-md-10">
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
            
            <script>
//             	manager_nick = '${manager_nick }';
//             	project_title = '${project_title }';
            	
// 	            $.ajax({
// 					url : '${cPath}/restapi/project/issue',
// 					type : 'get',
// 					data : {
// 						//'manager_nick' : manager_nick
// 					},
// 					success : function(res) {
						
// 						$.each(res, function(i, v) {
// 							let issueBox = $('#issue-template').children('.issueBox').clone();
// 							issueBox.attr('issue_sid',v.issue_sid);
// 							issueBox.children('.issue-title').text(v.issue_title);
// 							issueBox.children('.priority').text('즉시');
// 							issueBox.children('.issue-label').text('할일');
// 							issueBox.children('.milestone').text('설계구현');
// 							issueBox.children('.issue-assignee').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
// 							issueBox.children('.issue-writer').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
// 							issueBox.children('.reply').children('span').text('3');
							
// 							$('#issuelist').append(issueBox);
// 						})
						
// 					},
// 					error : function(xhr, error, msg) {
// 						console.log(xhr);
// 						console.log(error);
// 						console.log(msg);
// 					},
// 					dataType : 'json'
// 				})
            </script>
            
            
            
            
            
            
            