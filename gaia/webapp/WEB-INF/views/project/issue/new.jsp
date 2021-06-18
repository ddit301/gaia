<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="newissueTemplate" hidden="true">
<!-- 	담당자 템플릿 - 목록 -->
	<a class="assigneebox dropdown-item">
		<div class="assigneecheck">
			<i class="icon-check" hidden="true"></i>
		</div>
		<img class="profile" src="/resources/images/profiles/default">
		<span>닉네임</span>
	</a>
<!-- 	담당자 템플릿 - 지정됨 -->
	<li class="assigned">
		<img class="profile" src="/resources/images/profiles/1">
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

<div class="container-fluid">
	<div class="row">
		<div class="col-md-9">
			<div class="issueTitle">
				<input type="text" placeholder="Title"/>
			</div>
			<div id="editor"></div>
			<button id="saveIssue" class="btn btn-success" disabled>이슈 등록</button>
		</div>
		<div class="menulist col-md-3">
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
<!-- 	      칸반 바로등록   menubox 시작 -->
			<div class="menubox card">
				<div class="regkanban menubox-header">
					<button class="btn" type="button">
					    <label for="addToKanban">칸반에 바로 등록
							<input id="addToKanban" type="checkbox" checked>
					    </label>
					</button>
				</div>
			</div>
<!-- 	         menubox 끝 -->
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
	
	$(function(){
		// 화면 위로 올리기
		scrollUp();
		loadComponentsForNewIssue();
		
		// datePicker 동작시키기
	    $('.datePick').bootstrapMaterialDatePicker({
	    	// 시간은 설정 안하고 날짜만 선택할 것
	        time: false
	        // 설정은 최소 오늘 이후의 날자만 가능
	        ,minDate : new Date()
	    });
		
		// editor의 내용이 있을 때만 Comment 버튼 활성화
		editor.on('change', function(){
			checkValidationToInsertIssue();
		})
		$('.issueTitle').children('input').on('input', function(){
			checkValidationToInsertIssue();
		})
		
	})


</script>
            
            
            
            