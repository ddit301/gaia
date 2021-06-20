<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 22 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="container-fluid">
	<div class="issue-title row">
		<div class="namefield col-md-12">
			<span></span>
  			<i class="icon-note menu-icon"></i>
		</div>
   </div>
	<div class="issue-title-edit row" hidden="true">
		<input class="col-md-10" type="text" maxlength="50">
		<button class="btn btn-success">저장</button>
		<button class="btn btn-danger">취소</button>
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
     			<img id="myProfile" class="profile" onerror="imgOnErr()">
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
<!--             		menulist 시작 -->
		<div id="issueEditArea" class="menulist col-md-3">
<!-- 	        이슈 담당자 menubox 시작 -->
			<div class="menubox card">
				<div class="menubox-header dropdown">
					<button class="btn dropdown-toggle" type="button" id="issue-assignee-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <span>담당자</span>
					    <i class="icon-settings menu-icon"></i>
					</button>
					<div class="assigneeboxes dropdown-menu" aria-labelledby="issue-assignee-btn">
					</div>
				</div>
				<div class="menubox-body">
					<div id="assigneeGuys">
						<span id="noAssigneeSign">지정된 담당자가 없습니다.</span>
					</div>
				</div>
			</div>
<!-- 	         menubox 끝 -->
<!-- 	      마일스톤   menubox 시작 -->
			<div class="menubox card">
				<div class="menubox-header dropdown">
					<button class="btn dropdown-toggle" type="button" id="issue-milestone-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <span>마일스톤</span>
					    <i class="icon-settings menu-icon"></i>
					</button>
					<div class="milestoneBoxes dropdown-menu" aria-labelledby="issue-milestone-btn">
					</div>
				</div>
				<div class="menubox-body">
					<div id="selectedMilestone">
					</div>
					<span id="noMilestoneSign">지정된 마일스톤이 없습니다.</span>
				</div>
			</div>
<!-- 	         menubox 끝 -->
<!-- 	      라벨   menubox 시작 -->
			<div class="menubox card">
				<div class="menubox-header dropdown">
					<button class="btn dropdown-toggle" type="button" id="issue-milestone-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <span>라벨</span>
					    <i class="icon-settings menu-icon"></i>
					</button>
					<div class="labelBoxes dropdown-menu" aria-labelledby="issue-milestone-btn">
						<div class="labelBox dropdown-item">
							<i class="icon-star"></i>
							<span>라벨명</span>
						</div>
					</div>
				</div>
				<div class="menubox-body">
					<div id="selectedLabel">
					</div>
					<span id="noLabelSign">지정된 라벨이 없습니다.</span>
				</div>
			</div>
<!-- 	         menubox 끝 -->
<!-- 	      중요도   menubox 시작 -->
			<div class="menubox card">
				<div class="menubox-header dropdown">
					<button class="btn dropdown-toggle" type="button" id="issue-milestone-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <span>중요도</span>
					    <i class="icon-settings menu-icon"></i>
					</button>
					<div class="issue-priority-list dropdown-menu" aria-labelledby="issue-milestone-btn">
						<a class="dropdown-item">급함</a>
						<a class="dropdown-item">보통</a>
						<a class="dropdown-item">빨리</a>
						<a class="dropdown-item">당장</a>
					</div>
				</div>
				<div class="menubox-body">
					<div id="issuePrioritySetting"></div>
					<span id="noPrioritySign">지정된 중요도가 없습니다.</span>
				</div>
			</div>
<!-- 	         menubox 끝 -->
<!-- 	      이슈 시작일   menubox 시작 -->
			<div class="menubox card">
				<div class="menubox-header datepickerHeader">
					<button class="btn" type="button">
						<label for="issue-start-date">
					    	이슈 시작일<i class="icon-settings menu-icon"></i>
					    </label>
						<input id="issue-start-date" class="datePick" type="text">
					</button>
				</div>
			</div>
<!-- 	         menubox 끝 -->
<!-- 	      이슈 마감일   menubox 시작 -->
			<div class="menubox card">
				<div class="menubox-header datepickerHeader">
					<button class="btn" type="button">
					    <label for="issue-end-date">
					    	이슈 마감일<i class="icon-settings menu-icon"></i>
					    </label>
						<input id="issue-end-date" class="datePick" type="text">
					</button>
				</div>
			</div>
<!-- 	         menubox 끝 -->
		</div>
<!-- 		menulist 끝 -->
	</div>
</div>
 
 <div id="issue-template" hidden="hidden" >	
	<!--  이슈 댓글 시작-->
	<div class="issue-reply row">
		<div class="col-md-1">
			<img class="commenter profile" onerror="imgOnErr()">
		</div>
		<div class="rep-right col-md-10 card">
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
<!-- 		<div class="col-md-1"></div> -->
		<div class="issue-edit-history col-md-9">
			<img class="profile issueHistory" src="" onerror="imgOnErr()">
			<span></span>
		</div>
		<div class="col-md-3">
			<span class="edittime"></span>
		</div>
	</div>
	<!--  이슈 수정내역 끝-->
</div>

<div id="newissueTemplate" hidden="true">
<!-- 	담당자 템플릿 - 목록 -->
	<a class="assigneebox dropdown-item">
		<div class="assigneecheck">
			<i class="icon-check" hidden="true"></i>
		</div>
		<img class="profile" onerror="imgOnErr()">
		<span>닉네임</span>
	</a>
<!-- 	담당자 템플릿 - 지정됨 -->
	<li class="assigned">
		<img class="profile nonlink" onerror="imgOnErr()">
		<span>최강한화</span>
	</li>
<!-- 	마일스톤 템플릿 -->
	<a class="new-issue-milestone dropdown-item">설계 구현하기</a>
<!-- 라벨 템플릿	 -->
	<div class="labelBox dropdown-item">
		<i></i>
		<span>라벨명</span>
	</div>
<!-- 이슈 중요도 템플릿 -->
	<a class="issue-priority dropdown-item">급함</a>
</div>
            
<script>
	issue_no = getUrlParameter();
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
		
		// datePicker 동작시키기
	    $('.datePick').bootstrapMaterialDatePicker({
	    	// 시간은 설정 안하고 날짜만 선택할 것
	        time: false
	        // 설정은 최소 오늘 이후의 날자만 가능
	        ,minDate : new Date()
	    });
		
		
		// editor의 내용이 있을 때만 Comment 버튼 활성화
		editor.on('change', function(){
			if((editor.getMarkdown()).length > 0 ){
				$('#issue-comment').attr('disabled', false);
			}else{
				$('#issue-comment').attr('disabled', true);
			}
		})
		
		loadIssue();
		
		// 시작일과 마감일 범위 제한 설정해주기
		if($('#issue-start-date').val()){
			$('#issue-end-date').bootstrapMaterialDatePicker("setMinDate", $('#issue-start-date').val());
		}
		if($('#issue-end-date').val()){
			$('#issue-start-date').bootstrapMaterialDatePicker("setMaxDate", $('#issue-end-date').val());
		}
		
		
     })
		
</script> 
            
            
            
            
            
            
            