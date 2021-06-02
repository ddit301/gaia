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
            			<span></span>
            		</div>
            		<div class="col-md-2">
            			<i class="icon-note menu-icon"></i>
            		</div>
            	</div>
            	<div class="issue-info row">
            		<div class="issue-status col-md-1">
            		</div>
            		<div class="writerinfo col-md-11">
	            		<span></span>
	            		this issue 
	            		<span></span>
            		</div>
            	</div>
            	<div class="issue-body row">
            		<div class="col-md-9">
            			<div id="issue-body-cont">
            			</div>
           				<div class="repWrite row">
		            		<div class="col-md-1">
		            			<img src="/gaia/resources/assets/images/user/2.png" alt="">
		            		</div>
		            		<div class="rep-right col-md-10">
		            			<div class="editorBody">
		            				<div id="editor"></div>
		            			</div>
		            			<div class="repFoot">
		            				<button type="button" class="btn mb-1 btn-warning">Close issue</button>
		            				<button id="issue-comment" type="button" class="btn mb-1 btn-success">Comment</button>
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
		            			<span></span>
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
				commented <span></span>
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
          		issue_no = '${issue_no}';
          		issue_sid = null;
          		
				// ToastUI Editor 에디터 적용시키기
				editor = new toastui.Editor({
				  el: document.querySelector('#editor'),
				  height: '200px',
				  initialEditType: 'markdown',
				  previewStyle: 'tab',
				  placeholder : 'markdown 문법을 지원합니다'
				});
				
	            $.ajax({
					url : getContextPath() + '/restapi/project/issues/'+issue_no,
					type : 'get',
					data : {
					},
					success : function(res) {
						issue_sid = res.issue_sid;
						$('#assignees').empty();
						$('#issue-body-cont').empty();
						
						$('.namefield').children('span').text(res.issue_title + ' #' + res.issue_no);
						if(res.milestone){
							$('#milestone').children('span').text(res.milestone.milest_title);
						}
						if(res.label){
							$('#label').children('span').text(res.label.label_nm);
						}
						$('#priority').children('span').text(
								res.priority == 1 ? '무시' :
								res.priority == 2 ? '낮음' :
								res.priority == 3 ? '보통' :
								res.priority == 4 ? '높음' :
								res.priority == 5 ? '긴급' : '즉시'
							);
						
						$('.writerinfo').children('span:first').text(res.writer.mem_nick + ' opened ');
						$('.writerinfo').children('span:last').text(moment(res.issue_create_date).fromNow());
						let statusLabel;
						if(res.issue_status = '0'){
							statusLabel = '<span class="label label-success">Oepn</span>'
						}else{
							statusLabel = '<span class="label label-danger">Closed</span>'
						}
						$('.issue-status').html(statusLabel);
	            		
						
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
								issue_history.attr('data-issue_his_no', v.issue_his_no);
								issue_history.find('.repHeader').children('span:first').text(v.historyWriter.mem_nick);
								issue_history.find('.repHeader').children('span:last').text(moment(v.issue_his_date).fromNow());
								// markdown 을 html로 번역해서 출력한다.
								issue_history.find('.repBody').html(converter.makeHtml(v.issue_his_cont));
							}else{
								issue_history = $('#issue-template').children('.issue-change').clone();
								issue_history.find('span').text('(히스토리타입/멤버닉네임 :' + v.issue_his_type +'/' + v.historyWriter.mem_nick +  ') ' + v.issue_his_cont);
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
				

				
				// document ready 됐을때 함수들 
				$(function(){
					// 이슈 코멘트 작성 이벤트
					$('#issue-comment').on('click', function(){
						let issue_his_cont = editor.getMarkdown();
						
						$.ajax({
							url : getContextPath() + '/restapi/project/issue-history',
							method : 'post',
							data : {
								'issue_sid' : issue_sid
								,'issue_his_cont' : issue_his_cont
								,'issue_his_type' : 'RE'
							},
							success : function(res) {
								let v= res.issueHistory;
								let issue_history;
									issue_history = $('#issue-template').children('.issue-reply').clone();
									issue_history.attr('data-issue_his_no', v.issue_his_no);
									issue_history.find('.repHeader').children('span:first').text('You');
									issue_history.find('.repHeader').children('span:last').text(moment(new Date()).fromNow());
									// markdown 을 html로 번역해서 출력한다.
									issue_history.find('.repBody').html(converter.makeHtml(v.issue_his_cont));
								$('#issue-body-cont').append(issue_history);
								// editor 비우기
								editor.reset()
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
            
            
            
            
            
            
            