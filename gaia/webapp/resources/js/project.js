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
const loadProject = function(managerId, projectTitle){
	
	// 비동기로 세션에 선택한 프로젝트를 기록한 뒤, 해당 프로젝트의 code 페이지를 로드 한다.
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
				movePageHistory('code');
			
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
			let projBox = $('#preloaderTemplate').children('.projBox').clone();
			let initial = project.proj_title.substring(0,1).toUpperCase();
			let projBtn = projBox.children('button');
			projBtn.text(initial);
			let tooltipText = project.proj_title;
			projBtn.attr('title', tooltipText);
			projBtn.attr('data-manager_id', mem_id);
			projBtn.attr('data-project_title', project.proj_title);
			projBoxes.append(projBox);
			// 동적으로 추가한 요소들에 툴팁 활성화 시켜준다.
			projBoxes.tooltip({
			    selector: '.square__box'
			});
			
			// 성공시 새로 만든 프로젝트로 이동한다.
			manager_id = mem_id; 
			project_title = project.proj_title;
			loadProject(manager_id,project_title);
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
		url : getContextPath() + '/restapi/project/loadProjectMembers.do', 
		type : 'get',
		data : {
			'searchword' : searchword
		},
		success : function(members) {
			let projMemList = $('#proj-mem-list');
			projMemList.empty();
			$.each(members, function(i,member){
				let memCard = $('#setting-member-template').children('.memcard').clone();
				
				memCard.attr('data-mem_no', member.mem_no);
				
				memCard.find('.proj-nick').text(member.proj_user_nick);
				memCard.find('.proj-role').text(member.mem_role_nm);
				memCard.find('.proj-in-date').text(moment(member.proj_join_date).format('LL'));
				memCard.find('.profileBox').children('img').attr('src',getProfilePath(member.member.mem_pic_file_name));
				
				projMemList.append(memCard);
			});
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})	
}




