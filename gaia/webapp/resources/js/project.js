$(function(){
	
 	// 클릭 이벤트가 아닌 url을 직접 입력해서 페이지를 호출했을 경우에는 해당 이벤트를 통해 매칭시켜줍니다.
 	// 처음 페이지를 호출 했을때도 아래의 코드를 탑니다.
	// 페이지 열릴때 멤버 관련된 url 이란 판단이 되면, movePageHistory 발동. member면 멤버쪽에서 발동.
	if(pageParam){
		if(pageParam == 'issueview'){
			issueView(issue_no);
		}else if(pageParam == 'milestoneview'){
			milestoneView(milest_no);
		}else{
			movePage(pageParam);
		}
	}
	
	/******************************************************
	*
	*       버튼 매핑 
	*
	 *****************************************************/
	
	// 프로젝트 선택시 해당 프로젝트로 이동하는 함수 호출
	$('body').on('click', '.projectBtn', function(){
		event.preventDefault();
		manager_id = $(this).data('manager_id'); 
		project_title = $(this).data('project_title');
		loadProject(manager_id,project_title);
		// 툴팁 hide 시키기
		$('.square__box').tooltip('hide');
		// 선택 메뉴 Code 로 바꾸기 (css)
		$('.metismenu').find('a').removeClass('selectedMenu');
		$('.metismenu').find('.codemenu').addClass('selectedMenu');
		// 선택 프로젝트 그림자 만들기
		$('.projBox').children('button').removeClass('selectedProj');
		$(this).addClass('selectedProj');
	});
	
	// 프로젝트 생성 버튼에 대한 바인딩
	$('body').on('click', '#createProjectBtn', function(){
		let proj_title = $('#proj_title_input').val();
		let proj_cont = $('#proj_cont_input').val();
		$('#projCreateModal').modal('hide');
		insertProject(proj_title, proj_cont);
	});
	
	// 프로젝트 생성 모달에서 취소를 누르건 생성을 누르건 내용을 비워준다.
	$('body').on('click', '#projCreateModal .modal-footer button', function(){
		$('#proj_title_input').val('');
		$('#proj_cont_input').val('');
	})
	
	// 프로젝트 멤버 목록에서 회원 클릭시 해당 멤버 관리 모달 열기
	$('body').on('click', '.memcard .card', function(){
		let card = $(this).parent();
		let selectedMemNo = card.data('mem_no');
		let proj_nick = card.data('proj_nick');
		let proj_role_no = card.data('proj_role_no');
		let mem_pic_file_name = card.data('mem_pic_file_name');
		let dropped = card.data('dropped');
		
		let selectedMember = {};
		selectedMember.selectedMemNo = selectedMemNo;
		selectedMember.proj_nick = proj_nick;
		selectedMember.proj_role_no = proj_role_no;
		selectedMember.mem_pic_file_name = mem_pic_file_name;
		selectedMember.dropped = dropped;
		
		manageProjMember(selectedMember);
	})
	
	// 회원 프로젝트에서 탈퇴시키는 버튼
	$('body').on('click', '#banMemberBtn', function(){
		let selectedMemNo = $('#proj_mem_no').text();
		let isBan = $(this).hasClass('btn-danger')
		if(isBan){
			banMember(selectedMemNo);
		}else{
			unBanMember(selectedMemNo);
		}
	})
	
	// 추가 프로젝트 멤버 초대 모달 띄우는 버튼
	$('body').on('click', '.pluscard', function(){
		$('#inviteMember').modal('show');
	});
	
	// 추가 프로젝트 멤버 초대할때 검색 하는 버튼
	$('body').on('click', '#memSearchBtn', function(){
		let keyword = $(this).parent().children('input').val();
		searchMember(keyword);
	});
	
	// 회원 초대 하려고 클릭 하는 이벤트
	$('body').on('click', '.searchedMember', function(){
		let selectedMemberLi = $(this);
		let selectedMemNo = $(this).data('mem_no');
		let selectedMemName = $(this).find('.memnm').text();
		inviteMember(selectedMemNo,selectedMemName,selectedMemberLi);
	})
	
	
	/******************************************************
	*
	*       이벤트 매핑 
	*
	 *****************************************************/
	
	// 프로젝트 이름 작성하는 곳 한글 입력 방지.
	document.querySelector('#proj_title_input').addEventListener('keyup', preventKorean);

	// 프로젝트 이름 변경시 비동기로 사용 가능한 이름인지 체크. input과 blur 이벤트 모두 바인딩
	$('body').on('input blur', '#proj_title_input', function(){
		checkProjTitleInput();		
	})
	
	// 멤버 역할 변경시 비동기로 바로 역할 변경 해준다.
	$('body').on('change', '#proj_mem_role', function(){
		let proj_mem_no = $('#proj_mem_no').text();
		let mem_role_no = $(this).val();
		changeMemberRole(proj_mem_no,mem_role_no,$(this));
	})

	
})

// 뒤로가기 상황을 제외하고는 pushState를 통해 데이터를 쌓아야합니다.
const movePageHistory = function(pageParam){
	var url = getContextPath()
		+'/'+manager_id+'/'+project_title 
		+ (pageParam!='code' ? '/'+pageParam : '');
	history.pushState(pageParam, null, url);
	movePage(pageParam);
}

// 뒤로가기 상황에서는 movePage 함수를 바로 호출합니다. 그렇지 않으면 history가 꼬이게 됩니다.
const movePage = function(pageParam){
	// project 페이지에서는 vertical로만 보여줍니다.
	new quixSettings({
	    layout: "vertical" // vertical or horizontal
	});
	// sideBar와 햄버거 메뉴를 보여줍니다.- 멤버에서는 안보이기 때문
	$('.nk-sidebar').removeAttr('hidden');
	$('.nav-control').removeAttr('hidden');
	
	scrollUp();
	
	if(!pageParam)
		pageParam = 'code';
	
	$.ajax({
		url : getContextPath() + '/view/project/' + pageParam,
		type : 'get',
		data : {
		},
		success : function(res) {
			$('.content-body').html(res);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'html'
	})
}

// 특정 프로젝트 선택시 해당 프로젝트로 이동하는 함수
const loadProject = function(managerId, projectTitle, pageParam){
	
	// 비동기로 세션에 선택한 프로젝트를 기록한 뒤, 해당 프로젝트의 pageParam으로 이동한다.
	// pageParam이 null 일 경우 'code'로 이동한다.
	$.ajax({
		url : getContextPath() + '/restapi/project/loadProject.do',
		type : 'get',
		data : {'manager_id' : managerId
				,'project_title' : projectTitle
			},
		success : function(res) {
			
			if(res == "OK"){
				// proj_user_nick 자바 스크립트 변수에 쿠키에서 새로 받아와 저장해준다.
				proj_user_nick = getProjNickFromCookie();
				movePageHistory(pageParam? pageParam : 'code');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType: 'json'
	})
	
}

// 소속된 프로젝트 목록을 불러와 왼쪽에 출력해주는 함수
const loadProjectList = function(){
		$.ajax({
		url : getContextPath() + '/restapi/project/projects',
		type : 'get',
		success : function(res) {
			let projBoxes = $('.proj_boxes');
			projBoxes.empty();
			$.each(res, function(i,project){
				let projBox = $('#preloaderTemplate').children('.projBox').clone();
				let initial = project.proj_title.substring(0,1).toUpperCase();
				let projBtn = projBox.children('button');
				projBtn.text(initial);
				let tooltipText = project.proj_title;
				projBtn.attr('title', tooltipText);
				projBtn.attr('data-manager_id', project.projectManager.mem_id);
				projBtn.attr('data-project_title', project.proj_title);
				projBoxes.append(projBox);
			})
			// 동적으로 추가한 요소들에 툴팁 활성화 시켜준다.
			projBoxes.tooltip({
			    selector: '.square__box'
			});
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType: 'json'
	})
}

const checkProjTitleInput = function(){
	let proj_title = $('#proj_title_input').val();
		let projTitleValidChecker = $('#projTitleValidChecker');
		let createProjectBtn = $('#createProjectBtn');
		if(!proj_title || (proj_title.indexOf(' ') >= 0) ){
			projTitleValidChecker.removeClass("icon-close");
			projTitleValidChecker.removeClass("icon-check");
			createProjectBtn.attr('disabled','disabled');
			return;
		}
		
	$.ajax({
		url : getContextPath() + '/restapi/project/projTitleCheck.do', 
		type : 'get',
		data : {
			'proj_title' : proj_title
		},
		success : function(result) {
			if(result == "OK"){
				// 사용할 수 있는 proj_title 일 경우
				projTitleValidChecker.removeClass("icon-close");
				projTitleValidChecker.addClass("icon-check");
				createProjectBtn.removeAttr('disabled');
			}else{
				// 사용할 수 없는 proj_title 일 경우
				projTitleValidChecker.removeClass("icon-check");
				projTitleValidChecker.addClass("icon-close");
				createProjectBtn.attr('disabled','disabled');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
}

const insertProject = function(proj_title, proj_cont){
	$.ajax({
		url : getContextPath() + '/restapi/project/projects', 
		type : 'post',
		data : {
			'proj_title' : proj_title
			,'proj_cont' : proj_cont
		},
		success : function(project) {
			// 왼쪽 프로젝트 navigator에 프로젝트를 추가해준다.
			let projBoxes = $('.proj_boxes');
			// selectedProj 버튼을 제거해준다.
			projBoxes.find('.selectedProj').removeClass('selectedProj');
			
			let projBox = $('#preloaderTemplate').children('.projBox').clone();
			let initial = project.proj_title.substring(0,1).toUpperCase();
			let projBtn = projBox.children('button');
			projBtn.text(initial);
			let tooltipText = project.proj_title;
			projBtn.attr('title', tooltipText);
			projBtn.attr('data-manager_id', mem_id);
			projBtn.attr('data-project_title', project.proj_title);
			projBtn.addClass('selectedProj');
			projBoxes.append(projBox);
			// 동적으로 추가한 요소들에 툴팁 활성화 시켜준다.
			projBoxes.tooltip({
			    selector: '.square__box'
			});
			
			// 성공시 새로 만든 프로젝트로 이동한다.
			manager_id = mem_id; 
			project_title = project.proj_title;
			loadProject(manager_id,project_title, 'management');
			// 선택 메뉴 management 로 바꾸기 (css)
			$('#sideSettingMenu').click();
			$('.metismenu').find('a').removeClass('selectedMenu');
			$('.metismenu').find('.managementmenu').addClass('selectedMenu');
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
}

// project에 속한 멤버들 불러오는 함수
const loadProjectMembers = function(searchword){
	$.ajax({
		url : getContextPath() + '/restapi/project/members', 
		type : 'get',
		data : {
			'searchword' : searchword
		},
		success : function(members) {
			let projMemList = $('#proj-mem-list');
			projMemList.empty();
			activeMembers = [];
			inactiveMembers = [];
			$.each(members, function(i,member){
				let memCard = $('#setting-member-template').children('.memcard').clone();
				
				memCard.attr('data-mem_no', member.mem_no);
				memCard.attr('data-proj_nick', member.proj_user_nick);
				memCard.attr('data-proj_role_no', member.mem_role_no);
				memCard.attr('data-mem_pic_file_name', member.member.mem_pic_file_name);
				memCard.attr('data-dropped', member.proj_drop_date? true:false);
				
				memCard.find('.proj-nick').text(member.proj_user_nick);
				memCard.find('.proj-role').text(member.mem_role_nm);
				memCard.find('.proj-in-date').text(moment(member.proj_join_date).format('LL'));
				memCard.find('.profileBox').children('img').attr('src',getProfilePath(member.member.mem_pic_file_name));
				
				memCard.addClass(member.proj_drop_date? 'dropped' :'');
				(member.proj_drop_date? inactiveMembers : activeMembers).push(memCard);
			});
			projMemList.append(activeMembers);
			projMemList.append(inactiveMembers);
			
			// 추가 멤버 초대 카드 
			let plusCard = $('#setting-member-template').children('.pluscard').clone();
			projMemList.append(plusCard);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})	
}

// 프로젝트 내 특정 회원 관리 함수
const manageProjMember = function(selectedMember){
	let modal = $('#mngProjMem');
	let selectedMemNo = selectedMember.selectedMemNo;
	let proj_nick = selectedMember.proj_nick;
	let proj_role_no = selectedMember.proj_role_no;
	let mem_pic_file_name= selectedMember.mem_pic_file_name;
	let dropped = selectedMember.dropped;
		
	// 해당 project의 멤버 role 들 받아와서 select 만들어준다.
	let projRoles = loadMemRoles();
	let roleSelector = $('#proj_mem_role');
	roleSelector.empty();
	$.each(projRoles, function(i,role){
		let selected = proj_role_no == role.MEM_ROLE_NO ? ' selected' : '';
		let option = '<option value="'+role.MEM_ROLE_NO+'"'+selected+'>'+role.MEM_ROLE_NM+'</option>';
		roleSelector.append(option);
	});
	
	// 화면 렌더링
	let banButton = $('#banMemberBtn')
	banButton.removeClass();
	banButton.addClass(dropped ? "btn btn-success" : "btn btn-danger");
	banButton.text(dropped ? "회원 복귀" : "회원 탈퇴");
	$('#proj_mem_no').text(selectedMemNo);
	$('#proj_mem_nick').text(proj_nick);
	$('#proj_mem_role').text();
	modal.find('.mngMemModal').children('img').attr('src', getProfilePath(mem_pic_file_name));
	modal.modal('show');
}

// 해당 프로젝트 내 멤버 role들 불러오는 함수
const loadMemRoles = function(){
	let roles = null;
	$.ajax({
		url : getContextPath() + '/restapi/project/roles', 
		type : 'get',
		success : function(res) {
			roles = res;
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
		,async : false
	})	
	return roles;
	
}

// 특정 회원의 mem_role 변경시키는 함수
const changeMemberRole = function(proj_mem_no,mem_role_no){
	$.ajax({
		url : getContextPath() + '/restapi/project/members', 
		type : 'post',
		data : {
			'_method' : 'put'
			,'mem_no' : proj_mem_no
			,'mem_role_no' : mem_role_no
		},
		success : function(res) {
			if(res == 'OK'){
				toastr.success('회원 역할 변경에 성공했습니다.');
				loadProjectMembers();
			}else{
				toastr.error('역할 변경에 실패했습니다.');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
		,async : false
	})	
}

// 특정 회원 프로젝트에서 탈퇴 시키는 함수
const banMember = function(selectedMemNo){
	// sweetAlert 버튼 초기화
	 swalWithBootstrapButtons = Swal.mixin({
		  customClass: {
			cancelButton: 'btn btn-light',
		   	confirmButton: 'btn btn-danger'
		  },
		  buttonsStyling: false
	})	
		
	swalWithBootstrapButtons.fire({
			  title: '정말 해당 회원을 탈퇴시키겠습니까?',
			  text: "탈퇴 후에도 되돌릴 수 있습니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonText: '탈퇴',
			  cancelButtonText: '취소',
			  reverseButtons: true
			}).then((result) => {
			  if (result.isConfirmed) {
			    swalWithBootstrapButtons.fire(
			      'Success!',
			      '해당 회원을 탈퇴 처리하였습니다.',
			      'success'
			    )
			    $.ajax({
					url : getContextPath() + '/restapi/project/members',
					method : 'post',
					data : {
						'mem_no' : selectedMemNo
						,'_method' : 'delete'
					},
					success : function(res) {
						loadProjectMembers();
						$('#mngProjMem').modal('hide');
					},
					error : function(xhr, error, msg) {
						ajaxError(xhr, error, msg)
					},
					dataType : 'json'
				})
			    
			  } else if (
			    result.dismiss === Swal.DismissReason.cancel
			  ) {
			  }
			})
}

// 특정 회원 프로젝트에 복귀 시키는 함수
const unBanMember = function(selectedMemNo){
	// sweetAlert 버튼 초기화
	 swalWithBootstrapButtons = Swal.mixin({
		  customClass: {
			cancelButton: 'btn btn-light',
		   	confirmButton: 'btn btn-success'
		  },
		  buttonsStyling: false
	})	
		
	swalWithBootstrapButtons.fire({
			  title: '정말 회원을 복귀시키겠습니까?',
			  text: "복귀 후에는 정상 활동이 가능합니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonText: '복귀',
			  cancelButtonText: '취소',
			  reverseButtons: true
			}).then((result) => {
			  if (result.isConfirmed) {
			    swalWithBootstrapButtons.fire(
			      'Success!',
			      '해당 회원을 복구 처리하였습니다.',
			      'success'
			    )
			    $.ajax({
					url : getContextPath() + '/restapi/project/members/return',
					method : 'post',
					data : {
						'mem_no' : selectedMemNo
						,'_method' : 'put'
					},
					success : function(res) {
						loadProjectMembers();
						$('#mngProjMem').modal('hide');
					},
					error : function(xhr, error, msg) {
						ajaxError(xhr, error, msg)
					},
					dataType : 'json'
				})
			    
			  } else if (
			    result.dismiss === Swal.DismissReason.cancel
			  ) {
			  }
			})
}


// 회원 초대위해 검색하는 function
const searchMember = function(keyword){
	
	    $.ajax({
		url : getContextPath() + '/restapi/project/members/search',
		method : 'get',
		data : {
			'keyword' : keyword
		},
		success : function(members) {
			let searchResultUl = $('#memSearchResult');
			searchResultUl.empty();
			$.each(members, function(i,member){
				let memberBox = $('#setting-member-template').find('.searchedMember').clone();
				memberBox.attr('data-mem_no', member.mem_no);
				memberBox.find('.memid').text(member.mem_id);
				memberBox.find('.memnick').text(member.mem_nick);
				memberBox.find('.memnm').text(member.mem_nm);
				memberBox.find('.memcity').text(member.mem_working_city);
				memberBox.find('img').attr('src', getProfilePath(member.mem_pic_file_name));
				searchResultUl.append(memberBox);
			})
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
	
	
}

// 멤버 초대하는 function
const inviteMember = function(selectedMemNo,selectedMemName,selectedMemberLi){
	// sweetAlert 버튼 초기화
	 swalWithBootstrapButtons = Swal.mixin({
		  customClass: {
			cancelButton: 'btn btn-light',
		   	confirmButton: 'btn btn-success'
		  },
		  buttonsStyling: false
	})	
		
	swalWithBootstrapButtons.fire({
			  title: '정말 '+selectedMemName+'님을 프로젝트에 초대하겠습니까?',
			  text: "초대 즉시 멤버로 등록됩니다.",
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonText: '초대',
			  cancelButtonText: '취소',
			  reverseButtons: true
			}).then((result) => {
			  if (result.isConfirmed) {
			    swalWithBootstrapButtons.fire(
			      'Success!',
			      selectedMemName+'님을 멤버로 등록했습니다.',
			      'success'
			    )
				// 확인 버튼 눌렀을때 가입정보 insert 해준다.
			    $.ajax({
					url : getContextPath() + '/restapi/project/members',
					method : 'post',
					data : {
						'mem_no' : selectedMemNo
						,'proj_user_nick' : selectedMemName 
					},
					success : function(res) {
						if(res == "OK"){
							selectedMemberLi.remove();
							loadProjectMembers();
						}
					},
					error : function(xhr, error, msg) {
						ajaxError(xhr, error, msg)
					},
					dataType : 'json'
				})
			    
			  } else if (
			    result.dismiss === Swal.DismissReason.cancel
			  ) {
			  }
			})
	
}












