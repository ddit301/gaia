// 버튼 매핑
$(function(){
	
	$('.content-body').on('click', '.projectName', function(){
		event.preventDefault();
		manager_id = $(this).data('manager_id'); 
		project_title = $(this).data('project_title');
		loadProject();
	});
	
})


const loadProject = function(){
	
	// 비동기로 세션에 선택한 프로젝트를 기록한 뒤, 해당 프로젝트의 code 페이지를 로드 한다.
	$.ajax({
		url : getContextPath() + '/restapi/project/loadProject.do',
		type : 'get',
		data : {'manager_id' : manager_id
				,'project_title' : project_title
			},
		success : function(res) {
			if(res == "OK"){
				movePageHistory('code');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType: 'json'
	})
	
	
	
}