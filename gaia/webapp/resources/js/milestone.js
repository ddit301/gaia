

////////////////////////////////////////////////////
//
// milestone 페이지 버튼 이벤트들 바인딩
//
////////////////////////////////////////////////////
$(function(){
	
	// 마일스톤 등록 버튼 이벤트
	$('.content-body').on('click', '#newMilestone', function(){
		newMilestone();
	})
	
	// 특정 마일스톤 클릭시 불러오는 메서드
	$('.content-body').on('click','.milestoneButton',function(){
		event.preventDefault();
		let milest_no = $(this).parents('.milestoneBox').data('milest_no');
		milestoneView(milest_no);
	})
	
   	// 마일스톤 이슈 all / open /closed 버튼
	$('.content-body').on('click', '.status-btn', function(){
		$('.status-btn').removeClass('btn-success');
		$('.status-btn').addClass('btn-light');
		$(this).removeClass("btn-light");
		$(this).addClass("btn-success");
		
		let milest_status = $(this).data('status');
		window.scrollTo({top:0, left:0, behavior:'auto'});
		milestonelist(milest_status);
    		
	});
	
	// 마일스톤 이슈 all / open /closed 버튼
	$('.content-body').on('click','#milestone-issue-chk .status-btn', function(){
		$('#milestone-issue-chk').children('button').removeClass('btn-success');
		$('#milestone-issue-chk').children('button').addClass('btn-light');
		$(this).removeClass("btn-light");
		$(this).addClass("btn-success");
		
		let issue_status = $(this).data('status');
		window.scrollTo({top:0, left:0, behavior:'auto'});
		milestoneissuelist(issue_status);
	});

	
	// milestone open / close 이벤트
 	$('.content-body').on('click', '#close-milest-btn', function(){
		milestoneOnOff();
	});
	
	// 모달창에서 마일스톤 삭제 버튼 클릭 시	 
	$('.content-body').on('click', '#delete-milest-btn', function(){
		delMilestone();
	});
	
	// 마일스톤 수정 취소 버튼 클릭 시 
	$('.content-body').on('click', '#milest-edit-close-btn', function(){
		milestoneView(milestObject.milest_no);
	})
	
	// 마일스톤 수정 버튼 클릭 시 
	$('.content-body').on('click', '.edit-milestone-btn', function(){
		editMilestone();
	})
	
	// 마일스톤 수정 중 close 버튼 누른 경우
	$('.content-body').on('click','#milest-edit-close-btn',function(){
		milestoneView(milestObject.milest_no);
	})
	
	// 작성된 마일스톤 등록
	$('.content-body').on('click', '.create-btn', function() {
		RegisterMilestone();
	})
	
	$('.content-body').on('change', 'newmilestone-form:input', function(){
		$('#newmilestone-form').valid();
	 }) 
	
	$('#newmilestone-form').validate({
			 onfocusout: false,
			 rules: {
				 milest_title : {
					 required: true
					 
				 }, milest_cont : {
					 required: true
					 
				 }
			 }, messages : {
				 milest_title : {
					 required : "This field is required."
				
				 }, milest_cont : {
					 required : "This field is required."
				 }
			 }
	 })

	$('.content-body').on('input', '.milest-input', function(){
		
		milest_title = milestTitleArea.val();
		milest_cont = milestContArea.val();
		
		if(milest_title.length * milest_cont.length != 0){
			$('.create-btn').prop('disabled',false);
		}else {
			$('.create-btn').prop('disabled',true);

		}
	})
	
	// 마일스톤 닫기 버튼 누른 경우
	$('.content-body').on('click','.mile-close',function(){
		movePage("milestone");
	})
	
	// 마일스톤 수정 저장 버튼 클릭
	$('.content-body').on('click', '#milest-changes-btn', function(){
		milestoneEditSave();
	})

})
	

// 마일스톤 생성 페이지로 이동하는 함수
const newMilestone = function(){
	movePageHistory('milestone/new');
}

// milestonelist 을 불러오는 함수
const milestonelist = function(milest_status){
    $.ajax({
		url : getContextPath()+'/restapi/project/milestones',
		type : 'get'
		,data :{
			'milest_status' : milest_status
		}
		,success : function(res) {
			$('#milestone-list').empty();
			
			$.each(res, function(i, v) {
				let milestoneBox = $('#milestone-template').children('.milestoneBox').clone();
				milestoneBox.attr('data-milest_no',v.milest_no);
				milestoneBox.find('.milestone-title').children('a').text(v.milest_title);
				milestoneBox.find('.milestone-descript').children('span').text(v.milest_cont);
				milestoneBox.find('.milestone-date').children('span').text((v.milest_start_date == null ? "시작일 없음." : v.milest_start_date) +' - '+(v.milest_end_date == null ? "종료일 없음." : v.milest_end_date));
				milestoneBox.find('.progress-bar').attr('style','width: '+v.milest_percent+'%;')
				milestoneBox.find('.milestone-percent').children('span').text((v.milest_percent == null ? 0 : v.milest_percent )+ '% complete '+(v.open_issue_cnt == null ? 0 : v.open_issue_cnt)+' open '+(v.close_issue_cnt == null ? 0 : v.close_issue_cnt)+' closed');
				
				$('#milestone-list').append(milestoneBox);
			})
		},
		error : function(xhr, error, msg) {
			console.log(xhr);
			console.log(error);
			console.log(msg);
		},
		dataType : 'json'
	})
 }

const milestoneOnOff = function(){
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
}	

const delMilestone = function(){
					
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
	
}

const editMilestone = function(){
	$.ajax({
		url : getContextPath()+'/view/project/editmilestone'
		,type : 'get'
		,data : {
			'manager_id' : manager_id
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
}

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
			
				let assigneeSize = v.assigneeList.length;
			
				$.each(v.assigneeList, function(j, assignee){
					if(assigneeSize == 1) j=99;
					// 이슈 담당자 이미지(여러명)
					issueBox.children('.issue-assignee').append(
							'<img class="profile assignee assignee'+j+'" src="'+getProfilePath(assignee.mem_pic_file_name)+'">');
					// 이슈 작성자 이미
					issueBox.children('.issue-writer').children('img').attr('src',getProfilePath(v.assigneeList[0].mem_pic_file_name));
				})
					if(v.replyCount > 0){
						issueBox.children('.reply').html(
								'<i class="icon-bubbles icons"></i><span>'+v.replyCount+'</span>'
							);
						
					}
					$('#milestone-issuelist').append(issueBox);
				})
				
			},
			error : function(xhr, error, msg) {
	
				console.log(xhr);
				console.log(error);
				console.log(msg);
			},
			dataType : 'json'
	
	})
}


const RegisterMilestone = function(){
	milest_title = $('#newmilestone-form').find('#milest_title').val();
	milest_start_date = $('.milest-start-date').children('input').val();
	milest_end_date = $('.milest-end-date').children('input').val();
	milest_cont = $('#newmilestone-form').find('#milest_cont').val();
	
	$.ajax({
		url : getContextPath() + '/restapi/project/milestones',
		type : 'post',
		data : {
			'milest_title' : milest_title,
			'milest_start_date' : milest_start_date,
			'milest_end_date' : milest_end_date,
			'milest_cont' : milest_cont
		},
		success : function(res) {

			milestoneView(res.milest_no);
		},
		error : function(xhr, error, msg) {
			console.log(xhr);
			console.log(error);
			console.log(msg);
		},
		dataType : 'json'
	})
}

const milestoneEditSave = function(){
	milest_title = $('.milestone-title').find('input').val();
	milest_start_date = $('.milest-start-date').children('input').val();
	milest_end_date = $('.milest-end-date').children('input').val();
	milest_cont = $('.form-text-group').children('textarea').val();
	milest_sid =  milestObject.milest_sid;
	
	$.ajax({
		url : getContextPath() + '/restapi/project/milestones',
		type : 'post',
		data : {
				'_method' : 'put'
				,'milest_sid' : milest_sid
                ,'milest_title' : milest_title
                ,'milest_start_date' : milest_start_date
                ,'milest_end_date' : milest_end_date
                ,'milest_cont' : milest_cont
                
			
            
		},
		success : function(res) {
			toastr.success('마일스톤 수정 성공');
			milestoneView(milestObject.milest_no);
		},
		error : function(xhr, error, msg) {
			console.log(xhr);
			console.log(error);
			console.log(msg);
		},
		dataType : 'json'

	})
}

// milestoneView
const milestoneView = function(milest_no){
	window.scrollTo({top:0, left:0, behavior:'auto'});
	
	data = 'milestoneView'+milest_no;
	title = '';
	url = getContextPath()+'/'+manager_id+'/'+project_title+'/milestone/'+milest_no;
	history.pushState(data,title,url);
	
	$.ajax({
		url : getContextPath()+'/view/project/milestoneview'
		,type : 'get'
		,data : {
			'manager_id' : manager_id
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
}






