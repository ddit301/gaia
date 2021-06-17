/**********************************

	Document Ready 시작

********************************/
$(function() {

	/**********************************
		버튼 매핑 시작
	********************************/
	
	// 프로젝트 소개 변경 버튼
	$('body').on('click', '#save_project_cont', function(){
		let project_cont = $('#mng_proj_cont').val();
		changeProjectCont(project_cont);
	});
	
	// 모듈 설정 저장 버튼
	$('body').on('click', '#saveModuleBtn', function(){
		saveModuleSetting();
	})

	/**********************************
					버튼 매핑 끝
			
		document ready 이벤트 바인딩 시작
	********************************/
	
	// 프로젝트 마감일 변경시 저장해주는 이벤트
	$('body').on('change', '#mng_proj_end', function(){
		let endDate = $(this).val();
		changeProjectEndDate(endDate);
	})
	
	// 라벨추가 단계에서 라벨명 입력시 이벤트
	$('body').on('input', '#label-name-input', function(){
		let inputText = $(this).val();
		$('#preview-labelBox').find('span').text(inputText);
	})
	
	// 라벨 추가 단계에서 아이콘 선택시 이벤트
	$('body').on('click', '#label-icon-select i', function(){
		let icon = $(this).attr('class');
		$('#label-icon-input').val(icon);
		let previewIcon = $('#preview-labelBox').find('i');
		previewIcon.removeAttr('class');
		previewIcon.addClass(icon);
	}) 
	
	// 라벨에 우클릭 이벤트 바인딩
	$.contextMenu({
		selector: '.labelBox',
		items: {
			edit: {
				name: "라벨 수정",
				callback: function(key, opt) {
					let label = $(this)
					rightClickedLabel = label;
					editLabel(label);
				}
			}
			,delete: {
				name: "라벨 삭제",
				callback: function(key, opt) {
					let label = $(this);
					deleteLabel(label);
				}
			}
		},
		events: {
			show: function(opt) {
				var $this = this;
				$.contextMenu.setInputValues(opt, $this.data());
			},
			hide: function(opt) {
				var $this = this;
				$.contextMenu.getInputValues(opt, $this.data());
			}
		}
	});
	


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

// 프로젝트 관리 페이지에서 쓸 데이터를 불러오는 함수
const loadProjectForManagement = function(){
	$.ajax({
			url : getContextPath() + '/restapi/project/loadProjectForManagement.do',
			method : 'get',
			success : function(project) {
				// 프로젝트 설명 출력
				$('#mng_proj_cont').val(project.proj_cont);
				
				// 예정 마감일 출력
				let enddate = project.proj_est_end_date;
				$('#mng_proj_end').val(enddate? moment(enddate).format('YYYY-MM-DD') : '');
				
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

// 특정 div안의 checkbox 들에 이진수 형태의 data에 맞게 체크를 해주는 함수
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

// 체크박스들의 체크 상태를 이진수 데이터로 바꿔 반환해주는 함수
const binaryDataReader = function(div){
	let areas = div.children('div');
	let areasize = areas.length;
	let sum = 0;
	for(i=0; i<areasize; i++){
		let inputArea = div.children().eq(i).find('input');
		sum += Math.pow(2, (areasize-1-i) ) * (inputArea.prop("checked")? 1 : 0);
	}
	return sum;
	
}

// 프로젝트 설명 변경해주는 함수
const changeProjectCont = function(proj_cont){
	$.ajax({
		url : getContextPath() + '/restapi/project/projects',
		method : 'post',
		data : {
			'proj_cont' : proj_cont
			,'_method' : 'put'
		},
		success : function(res) {
			if(res == "OK"){
				toastr.success('프로젝트 소개를 정상적으로 업데이트 했습니다 .');
			}else{
				toastr.error('에러 발생. 정상적으로 수정되지 않았습니다.');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
}

// 프로젝트 마감일 설정 함수
const changeProjectEndDate = function(proj_est_end_date){
	$.ajax({
		url : getContextPath() + '/restapi/project/projects',
		method : 'post',
		data : {
			'proj_est_end_date' : proj_est_end_date
			,'_method' : 'put'
		},
		success : function(res) {
			if(res == "OK"){
				toastr.success('프로젝트 예정 마감일을 정상적으로 변경했습니다.');
			}else{
				toastr.error('에러 발생. 정상적으로 수정되지 않았습니다.');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
}

// 모듈 설정 함수
const saveModuleSetting = function(){
	let moduleDiv = $('#mng_module');
	let proj_module_set = binaryDataReader(moduleDiv);
	
	$.ajax({
		url : getContextPath() + '/restapi/project/projects',
		method : 'post',
		data : {
			'proj_module_set' : proj_module_set
			,'_method' : 'put'
		},
		success : function(res) {
			if(res == "OK"){
				toastr.success('프로젝트 모듈 설정을 정상적으로 변경했습니다.');
			}else{
				toastr.error('에러 발생. 정상적으로 수정되지 않았습니다.');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
	
}

// 이슈 중요도 설정 함수
const saveIssueSetting = function(){
	let div = $('#issue_module');
	let issue_priority_set = binaryDataReader(div);
	
	$.ajax({
		url : getContextPath() + '/restapi/project/projects',
		method : 'post',
		data : {
			'issue_priority_set' : issue_priority_set
			,'_method' : 'put'
		},
		success : function(res) {
			if(res == "OK"){
				toastr.success('이슈 중요도 설정을 정상적으로 변경했습니다.');
			}else{
				toastr.error('에러 발생. 정상적으로 수정되지 않았습니다.');
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
	
}

// 라벨 추가 혹은 수정 할 경우 모두 처리하는 함수
const addOrEditLabel = function(){
	let label_nm = $('#label-name-input').val();
	let label_icon = $('#label-icon-input').val();
	let label_color = $('#label-color-input').val();
	let label_no = $('#label-no-input').val();
	let method = label_no? 'put' : 'post'
	
	$.ajax({
		url : getContextPath() + '/restapi/project/labels',
		method : 'post',
		data : {
			'label_nm' : label_nm
			,'label_icon' : label_icon
			,'label_color' : label_color
			,'label_no' : label_no
			,'_method' : method
		},
		success : function(label) {
			
			// 라벨을 추가한 경우
			if(method == 'post'){
				toastr.success('"'+label.label_nm+'" 라벨을 성공적으로 추가했습니다.');
				
				let labelBoxTemplate = $('#manage-template').find('.labelBox')
				let labelBoxArea = $('#labelBoxArea');
				let labelBox = labelBoxTemplate.clone();
				
				labelBox.attr('data-label_no', label.label_no);
				labelBox.find('i').addClass(label.label_icon);
				labelBox.find('span').text(label.label_nm);
				labelBox.css({"backgroundColor":label.label_color});
				
				labelBoxArea.append(labelBox);
			}else{
				// 라벨을 수정한 경우
				rightClickedLabel.attr('data-label_no', label.label_no);
				rightClickedLabel.find('i').removeAttr('class');
				rightClickedLabel.find('i').addClass(label.label_icon);
				rightClickedLabel.find('span').text(label.label_nm);
				rightClickedLabel.css({"backgroundColor":label.label_color});
				toastr.success('라벨을 수정했습니다.');
			}
			$('#addLabelModal').modal('hide');
			
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
	
	
}

// 라벨 삭제
const deleteLabel = function(label){
	let label_no = label.data('label_no');
	let label_nm = label.find('span').text(); 
	
	// sweetAlert 버튼 초기화
	 swalWithBootstrapButtons = Swal.mixin({
		  customClass: {
			cancelButton: 'btn btn-light',
		   	confirmButton: 'btn btn-danger'
		  },
		  buttonsStyling: false
	})	
	
	swalWithBootstrapButtons.fire({
		  title: '정말로 "'+label_nm+'"라벨을 삭제하시겠습니까?',
		  text: "삭제시 되돌릴 수 없습니다!",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonText: '삭제',
		  cancelButtonText: '취소',
		  reverseButtons: true
		}).then((result) => {
		  if (result.isConfirmed) {
		    swalWithBootstrapButtons.fire(
		      'Deleted!',
		      '라벨을 삭제했습니다.',
		      'success'
		    )
		    
		    $.ajax({
				url : getContextPath() + '/restapi/project/labels',
				method : 'post',
				data : {
					'label_no' : label_no
					,'_method' : 'delete'
				},
				success : function(res) {
					if(res == "OK"){
						label.remove();
					}else{
						alert('삭제에 실패했습니다. 지속해서 문제 발생시 관리자에게 문의해주세요.');				
					}
				},
				error : function(xhr, error, msg) {
					ajaxError(xhr, error, msg)
				},
				dataType : 'json'
			})
		    
		  } else if (
		    /* Read more about handling dismissals below */
		    result.dismiss === Swal.DismissReason.cancel
		  ) {
		  }
		})
}

// 라벨 추가 버튼 눌렀을 경우 라벨 추가용으로 셋팅해주기
const labelAddModalSetting = function(){
	$('#addLabelModalLabel').text('라벨 추가');
	$('#preview-labelBox').find('span').text('라벨명');
	$('.tui-colorpicker-palette-hex').val('#f8f8f8');
	$('#preview-labelBox').css({"backgroundColor":'#f8f8f8'});
	$('#preview-labelBox').find('i').removeAttr('class');
	$('#preview-labelBox').find('i').addClass('icon-plus');
	$('#label-no-input').val('');
	$('#label-name-input').val('라벨명');
	$('#label-color-input').val('#f8f8f8');
	$('#label-icon-input').val('icon-plus');
}


// 라벨 수정
const editLabel = function(label){
	// 라벨 수정 버튼 눌렀을 경우 수정용으로 셋팅해주기
	let label_no = label.data('label_no');
	let label_nm = label.find('span').text();
	let label_icon = label.find('i').attr('class');
	let label_color = rgbToHex(label.css("background-color"));
	
	$('#addLabelModalLabel').text('라벨 수정');
	$('#preview-labelBox').find('span').text(label_nm);
	$('.tui-colorpicker-palette-hex').val(label_color);
	$('#preview-labelBox').css({"backgroundColor":label_color});
	$('#preview-labelBox').find('i').removeAttr('class');
	$('#preview-labelBox').find('i').addClass(label_icon);
	$('#label-no-input').val(label_no);
	$('#label-name-input').val(label_nm);
	$('#label-color-input').val(label_color);
	$('#label-icon-input').val(label_icon);
	
	$('#addLabelModal').modal('show');
	
}


// rgb(221, 255, 255) 형태로 오는 rgb 값을 헥사 코드로 변환 시키는 함수
const rgbToHex = function (rgb_color) {
	rgb_color = rgb_color.substring(4, rgb_color.length-1);
	let colors = rgb_color.split(',');
	let r = parseInt(colors[0]);
	let g = parseInt(colors[1]);
	let b = parseInt(colors[2]);
	
	return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
}
const componentToHex = function(c) {
  var hex = c.toString(16);
  return hex.length == 1 ? "0" + hex : hex;
}









