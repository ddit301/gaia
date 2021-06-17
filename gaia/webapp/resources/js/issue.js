
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
	
	// 이슈 등록 버튼 이벤트
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

	// 작성한 이슈 등록 버튼
	$('.content-body').on('click', '#saveIssue', function(){
		registerIssue();
	});
	
	
	

	////////////////////////////////////////////////////
	//
	// issue 상세 페이지 버튼 이벤트들 바인딩
	//
	////////////////////////////////////////////////////
	
	// 이슈 열기/닫기 이벤트
	$('.content-body').on('click', '#closeBtn', function(){
		issue.issue_status = issue.issue_status == 0 ? 1 : 0;
		console.log('이슈 열기 이벤트 클릭');
				
		$.ajax({
			url : getContextPath() + '/restapi/project/issues',
			method : 'post',
			data : {
				'issue_sid' : issue.issue_sid
				,'issue_status' : issue.issue_status
				,'_method' : 'put'		
			},
			success : function(res) {
				console.log('success 발동');
				console.log(res.issue.issue_status);
				if(res.issue.issue_status == 0){
					console.log('if 에서 0 에 걸림');
					//상위 라벨
					$('.issue-status').children('span').text('Open');
					$('.issue-status').children('span').removeClass('label-danger');
					$('.issue-status').children('span').addClass('label-success');
					//바닥 버튼
					$('#closeBtn').text('Close issue');
					$('#closeBtn').removeClass('btn-primary');
					$('#closeBtn').addClass('btn-warning');
					// toastr 알람
					toastr.success('issue를 Open 했습니다.')
				}else{
					console.log('if 에서 else 에 걸림');
					//상위 라벨
					$('.issue-status').children('span').text('Closed');
					$('.issue-status').children('span').removeClass('label-success');
					$('.issue-status').children('span').addClass('label-danger');
					// 바닥 버튼 
					$('#closeBtn').text('Reopen issue');
					$('#closeBtn').removeClass('btn-warning');
					$('#closeBtn').addClass('btn-primary');
					// toastr 알람
					toastr.warning('issue를 Close 했습니다.')
				}
			},
			error : function(xhr, error, msg) {
				ajaxError(xhr, error, msg);
			},
			dataType : 'json'
		})
		
	});
	
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
	$.ajax({
		url : getContextPath() + '/restapi/project/issues/'+issue_no,
		type : 'get',
		data : {
		},
		success : function(res) {
			issue = res;
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
			
			// 이슈가 닫힌 상태면 그에 맞게 라벨과 버튼을 바꿔준다.
			if(issue.issue_status == 1){
				$('.issue-status').children('span').text('Closed');
				$('.issue-status').children('span').removeClass('label-success');
				$('.issue-status').children('span').addClass('label-danger');
				$('#closeBtn').text('Reopen issue');
				$('#closeBtn').removeClass('btn-warning');
				$('#closeBtn').addClass('btn-primary');
			}
          		
			
			$.each(res.assigneeList, function(i,v){
				let assigneeBox = $('#issue-template').children('p').clone();
				assigneeBox.children('span').text(v.mem_nick);
				assigneeBox.find('.profile').attr('src', getProfilePath(v.mem_pic_file_name));
				$('#assignees').append(assigneeBox);
			})
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
					issue_history.find('span').text('(히스토리타입/멤버닉네임 :' + v.issue_his_type +'/' + v.historyWriter.mem_nick +  ') ' + v.issue_his_cont);
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
	label_no = null;
	milest_sid = null;
	issue_title = $('.issueTitle').children('input').val();
	issue_content = editor.getMarkdown();
	issue_start_date = $('#issueStartDate').children('input').val();
	issue_end_date = $('#issueEndDate').children('input').val();
	issue_priority = 3;
	
	let addToKanban = $('#addToKanban').is(':checked');
	
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
	console.log(projectComponents);
	
	
}









