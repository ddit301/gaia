/**********************************

	Document Ready 시작

********************************/
$(function() {

	/**********************************
		버튼 매핑 시작
	********************************/


	/**********************************
					버튼 매핑 끝
			
		document ready 바인딩 시작
	********************************/






})
/**********************************

			Document Ready 끝

********************************/

/**********************************
	변수 선언부
********************************/

/**********************************
	함수 선언부
********************************/

const loadProjectForManagement = function(){
	$.ajax({
			url : getContextPath() + '/restapi/project/loadProjectForManagement.do',
			method : 'get',
			success : function(project) {
				// 프로젝트 설명 출력
				$('#mng_proj_cont').val(project.proj_cont);
				
				// 예정 마감일 출력
				let enddate = project.proj_est_end_date;
				$('#mng_proj_end').val(moment(enddate).format('YYYY-MM-DD'));
				
				// 사용 모듈 출력
				let moduleDiv = $('#mng_module');
				let moduleData = project.proj_module_set;
				binaryDataPrinter(moduleDiv, moduleData);
				
				// 이슈 중요도 출력
				let issueDiv = $('#issue_module');
				let issueData = project.issue_priority_set;
				binaryDataPrinter(issueDiv, issueData);
				
				// 라벨 목록 출력
				let labelBoxTemplate = $('#manage-template').find('.labelBox')
				let labelBoxArea = $('#labelBoxArea');
				labelBoxArea.empty();
				$.each(project.labelList, function(i,label){
					let labelBox = labelBoxTemplate.clone();
					labelBox.attr('data-label_no', label.label_no);
					labelBox.find('i').addClass(label.label_icon);
					labelBox.find('span').text(label.label_nm);
					labelBox.css({"backgroundColor":label.label_color});
					labelBoxArea.append(labelBox);
				});
				
				// 멤버 역할 목록 출력
				let roleBoxTemplate = $('#manage-template').find('.roleBox');
				let roleBoxArea = $('#roleBoxArea');
				roleBoxArea.empty();
				$.each(project.roleList, function(i, role){
					let roleBox = roleBoxTemplate.clone();
					roleBox.find('.rolename').find('span').text(role.mem_role_nm);
					roleBox.attr('data-mem_role_no', role.mem_role_no);
					let roleSelectDiv = roleBox.find('.role_auth_list');
					binaryDataPrinter(roleSelectDiv, role.authority);
					roleBoxArea.append(roleBox);
				})
				
			},
			error : function(xhr, error, msg) {
				ajaxError(xhr, error, msg);

			},
			dataType : 'json'
		})
}

const binaryDataPrinter = function(div, data){
	let areas = div.children('div');
	let areasize = areas.length;
	// data를 이진법으로 변경하며, 앞자리들을 0으로 채운다.
	let binaryData = data.toString(2).padStart(areasize,'0');
	
	for(i=0; i<areasize; i++){
		let inputArea = div.children().eq(i).find('input');
		// 해당하는 index가 1이면 check로 바꿔준다.
		if(binaryData.charAt(i) == '1'){
			inputArea.prop("checked", true);
		}
	}
	
}















