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
            			<span class="label label-success">Open</span>
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
		            			<img id="myProfile" class="profile" alt="">
		            		</div>
		            		<div class="rep-right col-md-10">
		            			<div class="editorBody">
		            				<div id="editor"></div>
		            			</div>
		            			<div class="repFoot">
		            				<button id="closeBtn" type="button" class="btn mb-1 btn-warning">Close issue</button>
		            				<button id="issue-comment" type="button" class="btn mb-1 btn-success" disabled>Comment</button>
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
		<img class="profile" alt="">
		<span></span>
	</p>
 	<!--  이슈 담당자 끝-->
	
	<!--  이슈 댓글 시작-->
	<div class="issue-reply row">
		<div class="col-md-1">
			<img class="commenter profile" alt="">
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
		<div class="col-md-10">
			<img class="profile issueHistory" src="" alt="">
			<span></span>
		</div>
	</div>
	<!--  이슈 수정내역 끝-->
	
</div>
            
<script>
	issue_no = '${issue_no}';
	issue = null;
       		
	// ToastUI Editor 에디터 적용시키기
	editor = new toastui.Editor({
	  el: document.querySelector('#editor'),
	  height: '200px',
	  initialEditType: 'markdown',
	  previewStyle: 'tab',
	  placeholder : 'markdown 문법을 지원합니다'
	});
	
	viewer = toastui.Editor.factory({
         el: document.querySelector('.repBody')
         ,height : 'auto'
         ,viewer : true
       });
				
///////////////////////////////////////////////////////////////
//////////								///////////////////////
//////////		on ready functions 		///////////////////////
//////////								///////////////////////
///////////////////////////////////////////////////////////////
	$(function(){
		
		$('#myProfile').attr('src',getProfilePath(mem_pic_file_name));
		
		// editor의 내용이 있을 때만 Comment 버튼 활성화
		editor.on('change', function(){
			if((editor.getMarkdown()).length > 0 ){
				$('#issue-comment').attr('disabled', false);
			}else{
				$('#issue-comment').attr('disabled', true);
			}
		})
		
		loadIssue();
		
		
     })
		
</script> 
            
            
            
            
            
            
            