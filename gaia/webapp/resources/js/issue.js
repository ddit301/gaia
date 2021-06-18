
$(function(){
	
	////////////////////////////////////////////////////
	//
	// issue 페이지 버튼 이벤트들 바인딩
	//
	////////////////////////////////////////////////////
	
	// 특정 이슈 클릭시 불러오는 메서드
	$('#main-wrapper').on('click', '.issueButton', function(){
		let issue_no = $(this).parents('.issueBox').data('issue_no');
		issueView(issue_no);
	})
	
	// 이슈 등록 페이지로 이동하는 버튼 이벤트
	$('.content-body').on('click', '#newIssueBtn', function(){
		newIssue();
	})
	
	// 이슈 페이징 버튼
	$('.content-body').on('click', '.pagination .page-link', function(){
 		event.preventDefault();
 		let dataBtn = $(this).data('btn');
 		if(dataBtn== 'prev'){
 			currentPage = parseInt(startPage) - 1;
 		}else if(dataBtn == 'next'){
 			currentPage = parseInt(endPage) + 1;
 		}else{
 			if(currentPage == $(this).text()){
 				return false;
 			}else{
  			currentPage = $(this).text();
 			}
 		}
 		window.scrollTo({top:0, left:0, behavior:'auto'});
 		loadIssueList();
 	});
	
	// 이슈 Open / Close 필터 버튼
	$('.content-body').on('click', '#iss-filter-btn button', function(){
 		$('#iss-filter-btn').children('button').removeClass('btn-success');
 		$('#iss-filter-btn').children('button').addClass('btn-light');
 		$(this).removeClass("btn-light");
 		$(this).addClass("btn-success");
 		
 		issue_status = $(this).data('status');
 		currentPage = 1;
 		window.scrollTo({top:0, left:0, behavior:'auto'});
 		loadIssueList();
 	});

	////////////////////////////////////////////////////
	//
	// issue 상세 페이지 버튼 이벤트들 바인딩
	//
	////////////////////////////////////////////////////
	
	// 이슈 코멘트 작성 이벤트
	$('.content-body').on('click', '#issue-comment', function(){
		let issue_his_cont = editor.getMarkdown();
		
		$.ajax({
			url : getContextPath() + '/restapi/project/issue-history',
			method : 'post',
			data : {
				'issue_title' : issue.issue_title
				, 'url' : getCurrentUrl()
				,'mem_no' : issue.writer.mem_no
				,'issue_sid' : issue.issue_sid
				,'issue_his_cont' : issue_his_cont
				,'issue_his_type' : 'RE'
			},
			success : function(res) {
				let v= res.issueHistory;
				let issue_history;
					// markdown 을 html로 번역해서 출력한다.
					viewer.setMarkdown(v.issue_his_cont);
					
					issue_history = $('#issue-template').children('.issue-reply').clone();
					issue_history.attr('data-issue_his_no', v.issue_his_no);
					issue_history.find('.repHeader').children('span:first').text(proj_user_nick);
					issue_history.find('.repHeader').children('span:last').text(moment(new Date()).fromNow());
					issue_history.find('.commenter').attr('src',getProfilePath(mem_pic_file_name));
				$('#issue-body-cont').append(issue_history);
				// editor 비우기
				editor.reset();
				// toastr 알람
				toastr.success('댓글 등록에 성공했습니다.')
			},
			error : function(xhr, error, msg) {
				ajaxError(xhr, error, msg);
			},
			dataType : 'json'
		})
		
	})
	
	////////////////////////////////////////////////////
	//
	// issue 상세조회 페이지 수정 이벤트들 바인딩
	//
	////////////////////////////////////////////////////
	
	// 담당자 추가 혹은 제거 이벤트
	$('body').on('click', '#issueEditArea .assigneeboxes .assigneebox', function(){
		let parameter = $(this).data('mem_no');
		let isAdd = $(this).find('i').prop('hidden');
		let assigneesSize = $('#assigneeGuys').find('.assigneebox').length;
		if( isAdd && assigneesSize>=4){
			return;
		}
		editIssue(isAdd? 'assigneeAdd' : 'assigneeDel', parameter);
	})
	
	// 마일스톤 변경 이벤트
	$('body').on('click', '#issueEditArea .milestoneBoxes .new-issue-milestone', function(){
		let parameter = $(this).data('milest_sid');
		editIssue('milest_sid', parameter);
	})
	
	// 마일스톤 제거 이벤트
	$('body').on('click', '#issueEditArea #selectedMilestone .new-issue-milestone', function(){
		editIssue('milest_sid');
	})
	
	// 라벨 변경 이벤트
	$('body').on('click', '#issueEditArea .labelBoxes .labelBox', function(){
		let parameter = $(this).data('label_no');
		editIssue('label_no', parameter);
	})
	
	// 라벨 제거 이벤트
	$('body').on('click', '#issueEditArea #selectedLabel .labelBox', function(){
		editIssue('label_no');
	})
	
	// 중요도 변경 이벤트
	$('body').on('click', '#issueEditArea .issue-priority-list .issue-priority', function(){
		let parameter = $(this).data('priority');
		editIssue('issue_priority', parameter);
	})
	
	// 중요도 제거 이벤트
	$('body').on('click', '#issueEditArea #issuePrioritySetting .issue-priority', function(){
		editIssue('issue_priority');
	})
	
	// 이슈 시작일 변경 이벤트
	$('body').on('change', '#issueEditArea #issue-start-date', function(){
		let parameter = $(this).val();
		editIssue('issue_start_date', parameter);
	})
	
	// 이슈 종료일 변경 이벤트
	$('body').on('change', '#issueEditArea #issue-end-date', function(){
		let parameter = $(this).val();
		editIssue('issue_end_date', parameter);
	})
	
	// 이슈 열기/닫기 이벤트 바인딩
	$('.content-body').on('click', '#closeBtn', function(){
		issue.issue_status = issue.issue_status == 0 ? 1 : 0;
		editIssue('issue_status', issue.issue_status);
				
		if(issue.issue_status == 0){
			//상위 라벨
			$('.issue-status').children('span').text('Open');
			$('.issue-status').children('span').removeClass('label-danger');
			$('.issue-status').children('span').addClass('label-success');
			//바닥 버튼
			$('#closeBtn').text('Close issue');
			$('#closeBtn').removeClass('btn-primary');
			$('#closeBtn').addClass('btn-warning');
		}else{
			//상위 라벨
			$('.issue-status').children('span').text('Closed');
			$('.issue-status').children('span').removeClass('label-success');
			$('.issue-status').children('span').addClass('label-danger');
			// 바닥 버튼 
			$('#closeBtn').text('Reopen issue');
			$('#closeBtn').removeClass('btn-warning');
			$('#closeBtn').addClass('btn-primary');
		}
		
	});
	
	// 이슈 제목 수정 이벤트
	$('.content-body').on('click', '.issue-title-edit .btn-success', function(){
		let parameter = $(this).siblings('input').val();
		$('.issue-title').find('span').text(parameter + ' #'+issue.issue_no);
		editIssue('issue_title', parameter);
		toggleTitleEdit();
	});
	
	// 이슈 제목 수정 취소 버튼
	$('.content-body').on('click', '.issue-title-edit .btn-danger', function(){
		$(this).siblings('input').val(issue.issue_title);
		toggleTitleEdit();
	});
	
	// 수정 화면 열기
	$('.content-body').on('click', '.issue-title i', function(){
		toggleTitleEdit();
	});
	
	
	
	
	////////////////////////////////////////////////////
	//
	//  작성 페이지 onload 이벤트들 바인딩
	//
	////////////////////////////////////////////////////
	
	// 작성한 이슈 등록 버튼
	$('.content-body').on('click', '#saveIssue', function(){
		registerIssue();
	});
	
	// 이슈 담당자 지정 버튼
	$('body').on('click', '.assigneeboxes .assigneebox', function(){
		let selectedBox = $(this);
		assigneeMember(selectedBox);		
	})
	
	// 마일스톤 지정 버튼
	$('body').on('click', '.milestoneBoxes .new-issue-milestone', function(){
		let selectedBox = $(this);
		assigneeMilestone(selectedBox);		
	})
	
	// 지정한 마일스톤 클릭시 마일스톤 선택 제거
	$('body').on('click', '#selectedMilestone .new-issue-milestone' , function(){
		$(this).remove();
		$('#noMilestoneSign').attr('hidden', false);
	})
	
	// 라벨 지정 버튼
	$('body').on('click', '.labelBoxes .labelBox', function(){
		let selectedBox = $(this);
		assigneeLabel(selectedBox);		
		$('#noLabelSign').attr('hidden', true);
	})
	
	//지정한 라벨 철회 버튼
	$('body').on('click', '#selectedLabel .labelBox', function(){
		let selectedBox = $(this);
		assigneeLabel(selectedBox);		
		
		// 라벨을 이전 자리로 돌려둔다.
		$('.labelBoxes').append(selectedBox);
		$('#noLabelSign').attr('hidden', false);
	})
	
	// 이슈 중요도 선택 버튼
	$('body').on('click', '.issue-priority-list .issue-priority', function(){
		let selectedBox = $(this).clone();
		$('#issuePrioritySetting').html(selectedBox);
		$('#noPrioritySign').attr('hidden', true);
	})	
	
	// 이슈 중요도 선택 취소
	$('body').on('click', '#issuePrioritySetting .issue-priority', function(){
		$(this).remove();
		$('#noPrioritySign').attr('hidden', false);
	})	
	
	// issue startDate 가 정해 진 후에는 endDate는 그 이후로만 적용할 수 있도록 막기
	$('body').on('change', '#issue-start-date', function(){
		let startDate = $('#issue-start-date').val();
		$('#issue-end-date').bootstrapMaterialDatePicker("setMinDate", startDate);
	})
	
	// issue endDate 가 정해 진 후에는 startDate는 그 이전으로만 적용할 수 있도록 막기
	$('body').on('change', '#issue-end-date', function(){
		let endDate = $('#issue-end-date').val();
		$('#issue-start-date').bootstrapMaterialDatePicker("setMaxDate", endDate);
	})
	
	

})

////////////////////////////////////////////////////////////////////////////////////////////
//
//
//  함수들 선언
//
//
////////////////////////////////////////////////////////////////////////////////////////////

// 이슈 목록 불러오는 함수
const loadIssueList = function(){
    $.ajax({
		url : getContextPath() + '/restapi/project/issues',
		type : 'get',
		data : {
			'issue_status' : issue_status
			,'currentPage' : currentPage
		},
		success : function(res) {
			$('#issuelist').empty();
			startPage = res.startPage;
			endPage = res.endPage;
			
			// pagination 만들어주기
			let prevBtn;
			let nextBtn;
			if(res.startPage <= 1){
				prevBtn = '<li class="page-item disabled"><a class="page-link" data-btn="prev" href="#" tabindex="-1">Previous</a></li>';
			}else{
				prevBtn = '<li class="page-item"><a class="page-link" data-btn="prev" href="#" tabindex="-1">Previous</a></li>';
			}
			if(res.endPage < res.totalPage){
				nextBtn = '<li class="page-item"><a class="page-link" data-btn="next" href="#">Next</a></li>';
			}else{
				nextBtn = '<li class="page-item disabled"><a class="page-link" data-btn="next" href="#">Next</a></li>';
			}
			
			let pageNation = prevBtn;
			for(i=res.startPage; i<=res.endPage && i<=res.totalPage; i++){
				if(res.currentPage == i){
					pageNation += '<li class="page-item active"><a class="page-link">'+ i +'</a></li>'
				}else{
					pageNation += '<li class="page-item"><a class="page-link">'+ i +'</a></li>'
				}
			}
			pageNation += nextBtn;
			$('.pagination').html(pageNation);
			
			$.each(res.dataList, function(i, v) {
				let issueBox = $('#issue-template').children('.issueBox').clone();
				issueBox.attr('data-issue_sid',v.issue_sid);
				issueBox.attr('data-issue_no',v.issue_no);
				issueBox.children('.issue-title').children('a').text(v.issue_title);
				issueBox.children('.issue-priority').text(
					v.issue_priority == 1 ? '무시' :
					v.issue_priority == 2 ? '낮음' :
					v.issue_priority == 3 ? '보통' :
					v.issue_priority == 4 ? '높음' :
					v.issue_priority == 5 ? '긴급' : '즉시'
					);
				if(v.label){
					issueBox.children('.issue-label').text(v.label.label_nm);
				}
				if(v.milestone){
					issueBox.children('.milestone').text(v.milestone.milest_title);
				}
				let assigneeSize = v.assigneeList.length;
				$.each(v.assigneeList, function(j, assignee){
					if(assigneeSize == 1) j=99;
					issueBox.children('.issue-assignee').append(
							'<img class="profile assignee assignee'+j+'" src="'+getProfilePath(assignee.mem_pic_file_name)+'">');
				})
				issueBox.children('.issue-writer').children('img').attr('src',getProfilePath(v.writer.mem_pic_file_name));
				if(v.replyCount > 0){
					issueBox.children('.reply').html(
							'<i class="icon-bubbles icons"></i><span>&nbsp;'+v.replyCount+'</span>'
						);
				}
				
				$('#issuelist').append(issueBox);
			})
			
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
}

// 이슈 상세 조회 페이지로 이동하는 함수
const issueView = function(issue_no){
	window.scrollTo({top:0, left:0, behavior:'auto'});
	
	data = 'issueView'+issue_no;
	title = '';
	url = getContextPath()+'/'+manager_id+'/'+project_title+'/issue/'+issue_no;
	history.pushState(data, title, url);
	
	$.ajax({
		url : getContextPath()+'/view/project/issueview'
		,type : 'get'
		,data : {
			'issue_no' : issue_no
			}
		,success : function(res){
			$('.content-body').html(res);
		}
		,error : function(xhr){
			alert('error : ' + xhr.status);
		},
		dataType : 'html'
	})
}

// 이슈 생성 페이지로 이동하는 함수
const newIssue = function(){
	movePageHistory('issue/new');
}

// 이슈 상세 정보 페이지에서 렌더링 하는 함수
const loadIssue = function(){
	// 컴포넌트 불러오기
	loadComponentsForNewIssue();
		
	$.ajax({
		url : getContextPath() + '/restapi/project/issues/'+issue_no,
		type : 'get',
		data : {
		},
		success : function(res) {
			issue = res;
			
			// 이슈 제목 출력
			$('.namefield').children('span').text(res.issue_title + ' #' + res.issue_no);
			$('.issue-title-edit').find('input').val(res.issue_title);
			
			// 담당자 존재시 담당자 출력
			let issueAssigneeNumbers = [];
			$.each(res.assigneeList, function(i,v){
				issueAssigneeNumbers.push(v.mem_no);
			})
			let assigneeBoxes = $('.assigneeboxes').find('.assigneebox');
			assigneeBoxesLength = assigneeBoxes.length;
			for(i=0; i<assigneeBoxesLength; i++){
				let selectedBox = assigneeBoxes.eq(i);
				let assigneeMemNo = selectedBox.data('mem_no');
				// 위에서 만든 issueAssigneeNumbers 배열에 mem_no가 속하면 지정해준다.
				if(issueAssigneeNumbers.includes(assigneeMemNo)){
					assigneeMember(selectedBox);
				}
			}
			
			// 마일스톤 존재시 출력
			if(res.milest_sid){
				let milestoneBoxes = $('.milestoneBoxes').find('.new-issue-milestone');
				let milestoneBoxesLength = milestoneBoxes.length;
				for(i=0; milestoneBoxesLength; i++){
					let selectedBox = milestoneBoxes.eq(i);
					let milestoneSid = selectedBox.data('milest_sid');
					// 지정된 마일스톤 번호를 찾았을 경우 선택 하고 break;
					if(milestoneSid == res.milest_sid){
						assigneeMilestone(selectedBox);
						break;
					}
				}
			}
			
			// 라벨 존재시 출력
			if(res.label_no){
				let labelBoxes = $('.labelBoxes').find('.labelBox');
				labelBoxesLength = labelBoxes.length;
				for(i=0; labelBoxesLength; i++){
					let selectedBox = labelBoxes.eq(i);
					let label_no = selectedBox.data('label_no');
					// 지정된 라벨 번호를 찾았을 경우 선택 하고 break;
					if(label_no == res.label_no){
						$('#noLabelSign').attr('hidden', true);
						assigneeLabel(selectedBox);
						break;
					}
				}
			}
			
			//중요도 존재시 출력 0일 경우가 있으니 null과 체크해야 한다.
			if(res.issue_priority != null){
				let priorityBoxes = $('.issue-priority-list').find('.issue-priority');
				let priorityBoxesLength = priorityBoxes.length;
				for(i=0; priorityBoxesLength; i++){
					let selectedBox = priorityBoxes.eq(i);
					let priority = selectedBox.data('priority');
					// 지정된 우선도 찾았을 경우 선택 하고 break;
					if(priority == res.issue_priority){
						$('#issuePrioritySetting').html(selectedBox.clone());
						$('#noPrioritySign').attr('hidden', true);
						break;
					}
				}
			}
			
			// 작성자 정보 및 작성 시간 프린트
			$('.writerinfo').children('span:first').text(res.writer.mem_nick + ' opened ');
			$('.writerinfo').children('span:last').text(moment(res.issue_create_date).fromNow());
			
			// 이슈가 닫힌 상태면 그에 맞게 버튼라벨을 바꿔준다.
			if(issue.issue_status == 1){
				$('.issue-status').children('span').text('Closed');
				$('.issue-status').children('span').removeClass('label-success');
				$('.issue-status').children('span').addClass('label-danger');
				$('#closeBtn').text('Reopen issue');
				$('#closeBtn').removeClass('btn-warning');
				$('#closeBtn').addClass('btn-primary');
			}
			
			// 이슈 시작일 & 종료일 출력
			if(res.issue_start_date)
				$('#issue-start-date').val(moment(res.issue_start_date).format('YYYY-MM-DD'));
			if(res.issue_end_date)
				$('#issue-end-date').val(moment(res.issue_end_date).format('YYYY-MM-DD'));
			
			// 히스토리 출력
			$.each(res.historyList, function(i,v){
				let issue_history;
				// 히스토리가 댓글일 경우와 댓글이 아닐 경우로 분기됩니다.
				if(v.issue_his_type == 'RE'){
					// markdown 을 html로 변환 한 후 템플릿에 미리 출력한다.
					viewer.setMarkdown(v.issue_his_cont);
					issue_history = $('#issue-template').children('.issue-reply').clone();
					issue_history.attr('data-issue_his_no', v.issue_his_no);
					issue_history.find('.repHeader').children('span:first').text(v.historyWriter.mem_nick);
					issue_history.find('.repHeader').children('span:last').text(moment(v.issue_his_date).fromNow());
					issue_history.find('.commenter').attr('src',getProfilePath(v.historyWriter.mem_pic_file_name));
				}else{
					issue_history = $('#issue-template').children('.issue-change').clone();
					issue_history.find('span').text(historyTypeToText(v));
					issue_history.find('.profile').attr('src',getProfilePath(v.historyWriter.mem_pic_file_name));
				}
				$('#issue-body-cont').append(issue_history);
			})
			
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
		,async : false
	})
}

const registerIssue = function(){
	let label_no = $('#selectedLabel').find('.labelBox').data('label_no');
	let milest_sid = $('#selectedMilestone').find('.new-issue-milestone').data('milest_sid');
	let issue_title = $('.issueTitle').children('input').val();
	let issue_content = editor.getMarkdown();
	let issue_start_date = $('#issue-start-date').val();
	let issue_end_date = $('#issue-end-date').val();
	let issue_priority = $('#issuePrioritySetting').find('.issue-priority').data('priority');
	let addToKanban = $('#addToKanban').is(':checked');
	let assigneeboxes = $('#assigneeGuys').find('.assigneebox');
	let assigneeSize = assigneeboxes.length;
	let assigneeMemNos = [];
	for(i=0; i<assigneeSize; i++){
		assigneeMemNos.push(assigneeboxes.eq(i).data('mem_no'));
	}
	
	$.ajax({
		url : getContextPath() + '/restapi/project/issues',
		method : 'post',
		data : {
			'label_no' : label_no
			,'milest_sid' : milest_sid
			,'issue_title' : issue_title
			,'issue_content' : issue_content
			,'issue_start_date' : issue_start_date
			,'issue_end_date' : issue_end_date
			,'issue_priority' : issue_priority
			,'addToKanban' : addToKanban
			,'assigneeMemNos' : assigneeMemNos.length>0 ? assigneeMemNos.join() : null
		},
		success : function(res) {
			// toastr 알람
			toastr.success('issue 등록에 성공했습니다.')
			
			// 작성 성공시에는 작성한 이슈 페이지로 넘겨버린다.
			issueView(res.issue_no);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
	
}

// 이슈 작성 페이지 렌더링 해주는 함수
const loadComponentsForNewIssue = function(){
	
	let projectComponents = loadProjectComponents();
	let members = projectComponents.members;
	let milestones = projectComponents.milestones;
	let labels = projectComponents.labels;
	let issuePriority = projectComponents.issuePriority;
	
	let templateArea = $('#newissueTemplate');
	// 멤버 목록을 담당자 버튼 내에 렌더링 해 준다.
	let assigneeBoxTemplate = templateArea.find('.assigneebox');
	let assigneeboxes = $('.menubox').find('.assigneeboxes');
	assigneeboxes.empty();
	$.each(members, function(i,member){
		let assigneebox = assigneeBoxTemplate.clone();
		assigneebox.attr('data-mem_no', member.mem_no);
		assigneebox.find('img').attr('src', getProfilePath(member.member.mem_pic_file_name));
		assigneebox.find('span').text(member.proj_user_nick);
		assigneeboxes.append(assigneebox);
	})
	
	// 마일스톤 목록을 화면에 출력해준다.
	let milestoneTemplate = templateArea.find('.new-issue-milestone');
	let milestoneBoxes = $('.menubox').find('.milestoneBoxes');
	milestoneBoxes.empty();
	$.each(milestones, function(i, milestone){
		let mileBox = milestoneTemplate.clone();
		mileBox.attr('data-milest_sid', milestone.milest_sid);
		mileBox.text(milestone.milest_title);
		milestoneBoxes.append(mileBox);
	})
	
	// 라벨 목록을 화면에 출력해준다.
	let labelBoxTemplate =  templateArea.find('.labelBox');
	let labelBoxes = $('.menubox').find('.labelBoxes');
	labelBoxes.empty();
	$.each(labels, function(i, label){
		let labelBox = labelBoxTemplate.clone();
		labelBox.attr('data-label_no', label.label_no);
		labelBox.find('i').addClass(label.label_icon);
		labelBox.find('span').text(label.label_nm);
		labelBox.css({"backgroundColor":label.label_color});
		labelBoxes.append(labelBox);
	})
	
	
	// 이슈 중요도를 화면에 출력해준다.
	let priorityTemplate =  templateArea.find('.issue-priority');
	let priorityBoxes = $('.menubox').find('.issue-priority-list');
	priorityBoxes.empty();
	
	let issuePriorityList = getStringArrayFromBinaryAndArray(issuePriority, priorities);
	let issuePrioritySize = issuePriorityList.length;
	
	for(i=0; i<issuePrioritySize; i++){
		let priorityBox = priorityTemplate.clone();
		let priorityText = issuePriorityList[i];
		priorityBox.text(priorityText);
		let issue_no = priorities.indexOf(priorityText);
		priorityBox.attr('data-priority', issue_no);
		priorityBoxes.append(priorityBox);
	}
	
}


// 이슈 담당자 지정 했을 경우 함수
const assigneeMember = function(selectedBox){
	let selectedMemNo = selectedBox.data('mem_no');
	let selectedItag = selectedBox.find('i');
	// 이미 지정된 멤버들에 관한 셀렉터들 
	let assigneeGuys = $('#assigneeGuys');
	let assignees = assigneeGuys.find('.assigneebox');
	let assigneesSize = assignees.length;
	let noAssigneeSign = $('#noAssigneeSign');
	
	// 담당자는 최대 4명까지만 지정 가능.
	if(assigneesSize >= 4 && isHidden(selectedItag)){
		toastr.info('담당자는 최대 4명까지만 지정 가능합니다.');
		return;
	}
	
	// v 체크의 hidden 상태를 toggle 해준다.
	toggleHidden(selectedItag);
	
	// 체크 하며 히든 상태가 더이상 아니게 되었을 경우 assigneeGuys에 append 해준다.
	if(!isHidden(selectedItag)){
		if(!assigneesSize){
			toggleHidden(noAssigneeSign);
		}
		let assigneeBox = selectedBox.clone();
		assigneeBox.find('.assigneecheck').remove();
		assigneeGuys.prepend(assigneeBox);
	}else{
		// 이미 체크되어 있던 멤버의 경우에는 담당자 목록에서 제거한다.
		for(i=0; i<assigneesSize; i++ ){
			let whoIsIt = assignees.eq(i);
			let theirMemNo = whoIsIt.data('mem_no');
			if(theirMemNo == selectedMemNo){
				whoIsIt.remove();
				break;
			}
		}
		if(assigneesSize == 1){
			// 1명만 지정되어 있었는데 그마저도 지정 해제한 경우
			toggleHidden(noAssigneeSign);
		}
	}
}


// 마일스톤 지정 했을 경우 함수
const assigneeMilestone = function(selectedBox) {
	let selectedMilestoneArea = $('#selectedMilestone');
	let selectedMiestone = selectedBox.clone();
	selectedMilestoneArea.html(selectedMiestone);
	$('#noMilestoneSign').attr('hidden', true);
}	


// 라벨 지정 했을 경우
const assigneeLabel = function(selectedBox){
	let selectedLabelArea = $('#selectedLabel');
	// 기존에 있던 라벨을 다시 돌려두고
	$('.labelBoxes').append(selectedLabelArea.find('.labelBox'));
	// 새로 선택한 라벨을 붙인다.
	selectedLabelArea.append(selectedBox);
}	


// 이슈 작성 페이지 검증부
const checkValidationToInsertIssue = function(){
	let titleLength = $('.issueTitle').children('input').val().length;
	let contLength = editor.getMarkdown().length;
	if( titleLength * contLength > 0 ){
		$('#saveIssue').prop('disabled', false);
	}else{
		$('#saveIssue').prop('disabled', true);
	}
}


// 이슈 데이터 수정 이벤트
const editIssue = function(editpart, parameter){
	
	$.ajax({
		url : getContextPath() + '/restapi/project/issues',
		method : 'post',
		data : {
			'issue_sid' : issue.issue_sid
			,'editpart' : editpart
			,'parameter' : parameter
			,'_method' : 'put'
		},
		success : function(history) {
			toastr.success('변경되었습니다.');
			issue_history = $('#issue-template').children('.issue-change').clone();
			issue_history.find('span').text(historyTypeToText(history));
			issue_history.find('.profile').attr('src',getProfilePathFromCookie());
			$('#issue-body-cont').append(issue_history);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
		,async : false
		
	})
	
}

// 이슈 제목 수정/ 취소 토글 해주는 함수
const toggleTitleEdit = function(){
	let titleDiv = $('.issue-title');
	let editDiv = $('.issue-title-edit');
	toggleHidden(titleDiv);
	toggleHidden(editDiv);
} 

// 이슈 history vo를 문장으로 출력 해주는 함수
const historyTypeToText = function(history){
	if(!history) return null;
	
	let hisWriter = history.historyWriter ? history.historyWriter.mem_nick : getProjNickFromCookie();
	let cont = history.issue_his_cont;
	let result = hisWriter + '님이 ';
	
	console.log(history);
	console.log(cont);
	
	switch(history.issue_his_type){
		case 'ET':
			result += '이슈 제목을 ' + roChecker(cont) + ' 변경했습니다.' ; 
			break;
		case 'EL':
			result += '라벨을 '+ roChecker(cont) +' 변경했습니다.'; 
			break;
		case 'EP':
			result += '중요도를 '+ roChecker(priorities[cont]) +' 변경했습니다.'; 
			break;
		case 'AA':
			result += rulChecker(cont) +' 담당자로 지정했습니다.'; 
			break;
		case 'EM':
			result += '마일스톤을 '+ roChecker(cont) +' 변경했습니다.'; 
			break;
		case 'ES':
			result += '이슈 시작일을 '+ roChecker(cont) +' 변경했습니다.'; 
			break;
		case 'EE':
			result += '이슈 종료일을 '+ roChecker(cont) +' 변경했습니다.'; 
			break;
		case 'RL':
			result += '라벨 설정을 초기화 했습니다.'; 
			break;
		case 'RP':
			result += '중요도를 설정을 초기화 했습니다.'; 
			break;
		case 'RA':
			result += rulChecker(cont) + ' 담당자에서 제거 했습니다.'; 
			break;
		case 'RM':
			result += '마일스톤 설정을 초기화 했습니다.'; 
			break;
		default :
			result += '등록되지 않는 이슈 히스토리 타입 에러';
			break;
	}
	
	return result;
	
}


















