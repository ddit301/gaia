<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <link href="${cPath }/resources/assets/css/issue.css" rel="stylesheet">
            <div class="container-fluid">
            	<div class="row">
	            	<div class="col-md-9">
	            		<div class="issueTitle">
	            			<input type="text" placeholder="Title"/>
	            		</div>
	            		<div id="editor"></div>
	            		<div class="btnDiv">
		            		<button id="saveIssue" class="btn btn-success">이슈 등록</button>
	            		</div>
	            	</div>
            		<div class="menulist col-md-3">
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
            			<div class="menuBox row">
            				<div id="issueStartDate" class="col-md-10">
		            			<p>이슈 시작일</p>
		            			<input type="text" class="result" placeholder="yyyy-mm-dd">
            				</div>
            				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
            				</div>
            			</div>
            			<div class="menuBox row">
            				<div id="issueEndDate" class="col-md-10">
		            			<p>이슈 마감일</p>
		            			<input type="text" class="result" placeholder="yyyy-mm-dd">
            				</div>
            				<div class="col-md-2">
		            			<i class="icon-settings menu-icon"></i>
            				</div>
            			</div>
            		</div>
            	</div>
           	</div>
<script>
editor = new toastui.Editor({
	  el: document.querySelector('#editor'),
	  height: '600px',
	  initialEditType: 'markdown',
	  previewStyle: 'vertical',
	  placeholder : 'markdown 문법을 지원합니다'
	});
	
	$.sampleFunction = function(){
		
	}

$(function(){
	// 작성한 이슈 등록
	$('#saveIssue').on('click', function(){
		label_no = null;
		milest_sid = null;
		issue_title = $('.issueTitle').children('input').val();
		issue_content = editor.getMarkdown();
		issue_start_date = $('#issueStartDate').children('input').val();
		issue_end_date = $('#issueEndDate').children('input').val();
		if(issue_start_date < issue_end_date){
			alert('이슈 시작')
		}
		issue_priority = 3;
		
		$.ajax({
			url : '${cPath}/restapi/project/issues',
			method : 'post',
			data : {
				'label_no' : label_no
				,'milest_sid' : milest_sid
				,'issue_title' : issue_title
				,'issue_content' : issue_content
				,'issue_start_date' : issue_start_date
				,'issue_end_date' : issue_end_date
				,'issue_priority' : issue_priority
			},
			success : function(res) {
				movePage(issue) 
			},
			error : function(xhr, error, msg) {
				console.log(xhr);
				console.log(error);
				console.log(msg);
			},
			dataType : 'json'
		})
	})
	
    $('.menuBox').find('input').bootstrapMaterialDatePicker({
        time: false
    });
	
})



</script>
            
            
            
            