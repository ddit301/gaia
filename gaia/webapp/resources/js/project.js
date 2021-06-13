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
	});
	
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








