/**********************************

	Document Ready 시작

********************************/
$(function() {

	/**********************************
		버튼 매핑 시작
	********************************/

	// file 탐색기에서 파일 선택시 이벤트
	$('.content-body').on('click', '.filename-text', function() {
		event.preventDefault();
		let type = $(this).data('type');
		let path = $(this).data('path');
		let download_url = $(this).data('download_url');
		// 폴더면 해당 폴더 탐색
		if (type == 'dir') {
			loadFilesFromGit(gitRepoUrl, path);
		}else{
			// 파일이면 해당 파일 실행
			openFileFromUrl(download_url);
		}
	})
	
	// 내 가입 정보 수정 하러 가는 버튼
	$('body').on('click' , '.projnick-mng p', function(){
		toggleProjNickChange();
	});
	
	// 내 가입 정보 수정 취소 버튼
	$('body').on('click', '.projnick-mng .btnArea .btn-warning', function(){
		toggleProjNickChange();
	});
	
	// 내 가입 정보 수정 저장 버튼
	$('body').on('click', '.projnick-mng .btnArea .btn-success', function(){
		changeProjNick();
		toggleProjNickChange();
	});
	
	// 소속 멤버 설정 클릭하면 멤버 설정 페이지로 이동
	$('body').on('click' , '.members-overview p', function(){
		movePageHistory('member');
	});	
	
	// 깃 저장소 등록 버튼
	$('body').on('click', '#regGit', function(){
		$('#addGitModal').modal('toggle');
	});
	
	// 깃 저장소 연동 해제
	$('body').on('click', '#removeGit', function(){
		removeGitRepo();
	});
	

	/**********************************
					버튼 매핑 끝
			
		document ready 바인딩 시작
	********************************/


	// 파일들에 우클릭 이벤트 바인딩 해 주기
	$.contextMenu({
		selector: '.filename-text.file',
		items: {
			filedown: {
				name: "파일 다운로드",
				callback: function(key, opt) {
					let downUrl = $(this).data('download_url');
					download(downUrl);
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
let gitRepoUrl = null;

/**********************************
	함수 선언부
********************************/

// 프로젝트에 속한 저장소들을 불러오는 함수
const loadRepositoryList = function() {
	
	scrollUp();

	$.ajax({
		url: getContextPath() + '/restapi/project/repositories',
		method: 'get',
		success: function(res) {
			let hasGit = false;
			let hasSvn = false;
			$.each(res, function(i, v) {
				// git 저장소가 있으면 loadGit 함수를 호출한다.
				if (v.REPO_TYPE == 'git') {
					gitRepoUrl = v.REPO_URL;
					let repoHeader = $('.git').find('.repoInfo').children('a');
					repoHeader.attr('href', 'https://github.com/' + gitRepoUrl);
					repoHeader.find('span').text(gitRepoUrl);
					
					// Github 연동 취소하는 버튼도 넣어준다.
					$('.git').find('.repoInfo').append('<button id="removeGit" class="btn btn-sm btn-danger">x</button>')
					
					loadGit(gitRepoUrl);
					hasGit = true;
				}else if(v.repo_type == 'svn'){
//					// svn 관련 데이터는 아직 미구현		
//					loadSvn(v);
				}
			});
			if(!hasGit){
				let fileNavHeader = $('.git').find('.fileNavHeader').children('span');
				// 깃 저장소 등록 버튼 만들기
				fileNavHeader.html('<p>연결된 Git 저장소가 없습니다. <a id="regGit">등록하기</a></p>');
			}
		},
		error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType: 'json'
	})

}

// git 저장소가 있을 경우 해당 정보를 화면에 출력해줍니다.
// 초기 git 관련된 화면들을 불러오는 과정입니다.
const loadGit = function(gitRepoUrl) {
	// 저장소 파일들 불러와 화면에 쏴주기
	loadFilesFromGit(gitRepoUrl, null);
	// 사용 언어들 정보 불러오기
	loadLanguageInfo(gitRepoUrl);

	// readme 불러와 화면에 쏴주기
	// #readmeArea를 뷰어로 변경하고
	viewer = toastui.Editor.factory({
		el: document.querySelector('#gitReadmeArea')
		, height: 'auto'
		, viewer: true
	});
	// repo 주소에서 readme를 받아와 화면에 출력해줍니다.
	let readmeMd = readmeFromRepo(gitRepoUrl);
	viewer.setMarkdown(readmeMd);
}

// 파일 사이즈를 byte 단위가 아닌 사이즈별로 정리해주는 함수
function fileSizeConverter(bytes, si = true, dp = 1) {
	const thresh = si ? 1000 : 1024;

	if (Math.abs(bytes) < thresh) {
		return bytes + ' Byte';
	}

	const units = si
		? ['KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']
		: ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
	let u = -1;
	const r = 10 ** dp;

	do {
		bytes /= thresh;
		++u;
	} while (Math.round(Math.abs(bytes) * r) / r >= thresh && u < units.length - 1);


	return bytes.toFixed(dp) + ' ' + units[u];
}

// URL 소스로 부터 파일 열어 확인시켜주는 함수
const openFileFromUrl = function(download_url){
	let fileName = getFileNameFromUri(download_url);
	let extension = getExtension(fileName);
	/**
		extension 별로 코드 편집기 실행 혹은 미디어 플레이어 실행 등 이벤트를 추후에 추가해야 합니다. 	
	 */
	window.open(download_url);
	
}

//uri 로 부터 파일 이름만 찾는 함수.
const getFileNameFromUri = function(fileUri){
	let lastIndexOfSlash = fileUri.lastIndexOf('/');
	return lastIndexOfSlash == -1 ? null : fileUri.substring(lastIndexOfSlash+1);
}

// 파일 이름으로 부터 확장자 얻는 함수.
const getExtension = function(fileName){
	let lastIndexOfComma = fileName.lastIndexOf('.');
	return lastIndexOfComma == -1 ? null : fileName.substring(lastIndexOfComma+1);
}

// Code 페이지 프로젝트 정보 불러오는 함수
const loadProjectOverview = function(){
	$.ajax({
		url : getContextPath() + '/restapi/project/projects/loadProjectOverview.do',
		method : 'get',
		success : function(project) {
			let overviewDiv = $('.project-overview')
			overviewDiv.find('.projtitle').text(project.proj_title.toUpperCase());
			$('.overview-cont').find('span').html(toBrTag(project.proj_cont));
			$('.manager-overview').find('.mem-overview-card').find('img').attr('src', getProfilePath(project.projectManager.mem_no));
			$('.manager-overview').find('.mem-overview-card').find('span').text(project.projectManager.mem_nick);
			
			// 내 정보 출력 (쿠키에서 받아옴)
			let myinfoArea = overviewDiv.find('.projnick-mng');
			myinfoArea.find('img').attr('src' , getProfilePathFromCookie());
			myinfoArea.find('span').text(getProjNickFromCookie());
						
			// 날짜에 따른 진척률 계산
			let startDate = project.proj_start_date;
			let endDate = project.proj_est_end_date;
			let total;
			let prog;
			
			if(endDate){
				total = moment(endDate) - moment(startDate);
				prog = moment() - moment(startDate);
			}			
			overviewDiv.find('.start-date').find('span').text(moment(startDate).format('YYYY-MM-DD'));
			overviewDiv.find('.end-date').find('span').text(endDate ? moment(endDate).format('YYYY-MM-DD') : '');
			let progPercent = endDate ? Math.round(prog / total * 1000) / 10 : 0;
			progPercent = progPercent > 100 ? 100 : progPercent ;
			
			let progressBar = $('.progress-bar');
			progressBar.text(progPercent + '%');
			progressBar.attr("style", 'width:' + progPercent + '%');
			
			let memListArea =  $('.members-overview').children('div');
			
			memListArea.empty();
			// 멤버 목록 반복문
			
			$('#howmanyMember').append(' '+project.memberList.length+'명');
			$.each(project.memberList, function(i,member){
				let memBox = $('#codeTemplates').find('.mem-overview-card').clone();
				memBox.find('img').attr('src', getProfilePath(member.memno));
				memBox.find('span').text(member.nick);
				memBox.find('small').text(member.role);
				memListArea.append(memBox);
			});
			
			 
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
}

const toggleProjNickChange = function(){
	let nickArea = $('.projnick-mng').find('span');
	let nickInputArea = $('.projnick-mng').find('input');
	nickInputArea.val(getProjNickFromCookie());
	let buttonArea = $('.projnick-mng').find('.btnArea');
	toggleHidden(nickArea);
	toggleHidden(nickInputArea);
	toggleHidden(buttonArea);
}

// 내 프로젝트 닉네임 변경하는 메서드
const changeProjNick = function(){
	let oldNick = $('.projnick-mng').find('.mem-overview-card').find('span').text();
	let nick = $('.projnick-mng').find('input').val();
	
	$.ajax({
		url : getContextPath() + '/restapi/project/members',
		method : 'post',
		data : {
			'proj_user_nick' : nick
			,'_method' : 'put'
		}, 
		success : function(result) {
			// 화면에 있는 모든 멤버 관련 정보들 중 나에 대한 정보는 프로젝트 닉네임을 변경해준다.
			if(result == 'OK'){
				
				// 나의 가입 정보에 있는 닉네임 변경
				$('.projnick-mng').find('.mem-overview-card').find('span').text(nick);
				
				// 프로젝트 관리자가 나라면 닉네임 변경
				let managerNickSpan = $('.manager-overview').find('span');
				if( managerNickSpan.text() == oldNick){
					managerNickSpan.text(nick);
				}
				
				// 소속 멤버 중에서 내것 찾아서 닉네임 변경
				let memberCards = $('.members-overview').find('.mem-overview-card');
				let memberCardsSize = memberCards.length;
				for(i=0; i< memberCardsSize; i++){
					let memNickSpan = memberCards.eq(i).find('span')
					if(memNickSpan.text() == oldNick){
						memNickSpan.text(nick);
						break;
					}
				}
				
			}
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
	
	
	
};




//////////////////////////////////////////////////////////////////////////////
//
//	 gitHub restAPI 활용 하는 함수 목록
//
//////////////////////////////////////////////////////////////////////////////

// 깃 요청 하기 전에 secret 코드가 있으면 인증된 요청을 보내고, 없으면 일반 요청을 보내는 beforeSend 함수 선언
const gitBeforeSend = function(xhr){
	if(gitHash){
		xhr.setRequestHeader("Authorization", "token " + gitHash)
	}
}

// 특정 github 저장소에서 readme 파일을 불러오는 함수
// url 형식은 ddit301/gaia 처럼 아이디/프로젝트 가 들어가면 됩니다.
// @return string
const readmeFromRepo = function(gitRepoUrl) {
	let decoded;
	$.ajax({
		url: 'https://api.github.com/repos/' + gitRepoUrl + '/readme',
		method: 'get',
		success: function(res) {
			decoded = Base64.decode(res.content);
		},
		beforeSend : gitBeforeSend,
		error: function(xhr, error, msg) {
		},
		dataType: 'json',
		async: false
	});
	return decoded;
}

// 마크다운으로 작성된 text를 html 으로 렌더링 해주는 함수
const renderMarkdown = function(text) {
	$.ajax({
		url: 'https://api.github.com/markdown',
		method: 'post',
		data: JSON.stringify({ "text": text }),
		success: function(res) {
			$('#testGit').append(res);
		},beforeSend : gitBeforeSend,
		error: function(xhr, error, msg) {
		},
		dataType: 'html',
	});
}

// 사용 언어에 대해 통계를 내주는 함수
const loadLanguageInfo = function(gitRepoUrl) {
	$.ajax({
		url: 'https://api.github.com/repos/' + gitRepoUrl + '/languages',
		method: 'get',
		success: function(languages) {
			let keys = Object.keys(languages);
			let langs = [];
			let counts = [];
			let total = 0;
			let otherlangTotal = 0;
			// 주요 언어는 최대 4개까지 표시 할 것.
			let primaryLanCount = (keys.length < 4 ? keys.length : 4);
			for(i=0; i< primaryLanCount ; i++){
				let key = keys[i];
				let value = languages[keys[i]];
				langs.push(key);
				counts.push(value);
				total = total + value;
			}
			// 언어가 4개 이상일 경우에는, 기타 언어들의 값을 합쳐 otherLang으로 표기한다.
			if(keys.length > 4){
				for(i = primaryLanCount; i<keys.length; i++ ){
					let value = languages[keys[i]];
					total = total + value;
					otherlangTotal = otherlangTotal + value;
				}
				langs.push('Others');
				counts.push(otherlangTotal);
			}
			let languageDiv = $('.repoHeader').find('.languageInfo').find('span');
			for(i=0; i<langs.length; i++){
				let lanTag = langs[i] + ' : ' + Math.round(counts[i]/total*1000)/10 +'%<br/>' ; 
				languageDiv.append(lanTag);
			}
		},beforeSend : gitBeforeSend,
		error: function(xhr, error, msg) {
		},
		dataType: 'json',
	});
}

// 깃허브에서 파일들 탐색하는 함수
const loadFilesFromGit = function(gitRepoUrl, path) {
	$.ajax({
		url: 'https://api.github.com/repos/' + gitRepoUrl + '/contents' + (path ? '/' + path : ''),
		method: 'get',
		success: function(contents) {
			// fileNav의 Body를 미리 셀렉트 해서 변수로 지정해둔다.
			let fileNavBody = $('.git').find('.fileNavBody');
			fileNavBody.empty();
			//			 각각의 file에 대해 정보를 입력해 파일탐색기에 한개씩 붙여준다.
			folders = [];
			files = [];
			
			$.each(contents, function(i, file) {
				let fileBox = $('#codeTemplates').children('.fileObj').clone();
				let fileIcon = file.type == 'file' ? 'doc' : 'folder';
				let fileSize = file.size == 0 ? '' : fileSizeConverter(file.size);
				let filenameElement = fileBox.find('.filename-text');

				// 렌더링 해줄 요소를 기입한다.
				filenameElement.text(file.name);
				fileBox.children('.filename').children('i').addClass('icon-' + fileIcon);
				fileBox.children('.filesize').children('.filesize-text').text(fileSize);

				// filenameElement에 클릭시 필요한 데이터들을 기입해준다.
				filenameElement.addClass(file.type);
				filenameElement.attr('data-type', file.type);
				filenameElement.attr('data-path', file.path);
				if (file.type == 'file')
					filenameElement.attr('data-download_url', file.download_url);

				// 파일인지 폴더인지에 따라 각각의 배열에 push 한다.
				(file.type == 'file' ? files : folders).push(fileBox);
			})
			
			// fileNavHeader를 select 한 후, basePath를 보여준다.
			let fileNavHeader = $('.git').find('.fileNavHeader').children('span');
			// 보고 있는 폴더가 basePAth 일 경우에는 해당 요소에서 filename-text 클래스를 제외시켜준다.
			let basePath = $('<a '+ (path? 'class="filename-text"' : '') +' data-type="dir">'+gitRepoUrl+'</a>');
			fileNavHeader.html(basePath);
			
			//	지금 보고있는 경로가 Base 폴더가 아닐 경우에는 뒤로 가기 폴더를 만들어준다.
			if (path) {
				let fileBox = $('#codeTemplates').children('.fileObj').clone();
				let filenameElement = fileBox.find('.filename-text');
				filenameElement.text('..');
				fileBox.children('.filename').children('i').addClass('icon-folder');
				fileBox.addClass('baseFolder');

				parentPath = path.lastIndexOf('/') == -1 ? null : path.substring(0, path.lastIndexOf('/'));

				filenameElement.attr('data-type', 'dir');
				filenameElement.attr('data-path', parentPath);
				filenameElement.attr('href', "https://github.com/" + gitRepoUrl + (parentPath ? '/' + parentPath : ''));

				fileNavBody.append(fileBox);
				
				// path 가 null 이 아닐 경우에는 현제까지의 경로를 표시해준다.
				paths = path.split('/');
				pathLength = paths.length;
				for(i=0; i<pathLength; i++ ){
					let pathTag = $('#codeTemplates').find('.filename-text').clone();
					pathTag.attr('data-type', 'dir');
					pathTagDir='';
					for(j=0; j<=i; j++){
						pathTagDir = pathTagDir + (j==0?'':'/') + paths[j];
					}
					pathTag.attr('data-path', pathTagDir)
					pathTag.text(paths[i]);
					fileNavHeader.append(' / ');
					// 경로의 마지막이면 버튼 비활성화
					if(i == pathLength-1){
						pathTag.removeClass('filename-text');
					}
					fileNavHeader.append(pathTag);
				}
				
			}
			// 폴더 - 파일 순으로 출력 해 준다.
			fileNavBody.append(folders);
			fileNavBody.append(files);
		},beforeSend : gitBeforeSend,
		error: function(xhr, error, msg) {
		},
		dataType: 'json',
		async: false
	});
}

// Github에서 유저 정보 받아오는 메서드
const getGitUserInfo = function(username) {
	let userinfo;
	$.ajax({
		url: 'https://api.github.com/users/' + username,
		method: 'get',
		success: function(res) {
			userinfo = res;
		},beforeSend : gitBeforeSend,
		error: function(xhr, error, msg) {
		},
		dataType: 'json',
		async: false
	});
	return userinfo;
}

// gitHub 에서 저장소 정보 받아오는 메서드
const getGitRepoInfo = function(username, reponame){
	let repoInfo;
	$.ajax({
		url: 'https://api.github.com/repos/' + username + '/' + reponame,
		method: 'get',
		success: function(res) {
			repoInfo = res;
		},beforeSend : gitBeforeSend,
		error: function(xhr, error, msg) {
		},
		dataType: 'json',
		async: false
	});
	return repoInfo;
}

// 깃 아이디 체크하는 메서드
const gitIdCheck = function(){
	let gitId = $('#gitId').val();

	// 아이콘 클래스 초기화
	let icon = $('.gitIdArea').find('i');
	icon.removeClass();

	if(gitId.length < 2) return;

	// 해당하는 사용자가 있는지 확인
	let userInfo = getGitUserInfo(gitId);
	if(userInfo){
		icon.addClass('icon icon-check');
	}else{
		icon.addClass('icon icon-close');
	}
}

// 깃 repo 체크하는 메서드
const gitRepoCheck = function(){
	let gitId = $('#gitId').val();
	let repoName = $('#repoName').val();
	
	// 아이콘 클래스 초기화
	let icon = $('.gitRepoArea').find('i');
	icon.removeClass();
	
	if(gitId.length < 2 || repoName.length < 2) return;
	
	let repoInfo = getGitRepoInfo(gitId, repoName);
	
	if(repoInfo){
		icon.addClass('icon icon-check');
		$('#addGitRepoBtn').prop('disabled', false);
	}else{
		icon.addClass('icon icon-close');
	}
} 

// 깃 저장소 등록 메서드
const saveGitRepo = function(){
	
	let gitId = $('#gitId').val();
	let repoName = $('#repoName').val();
	let repo_url = gitId + '/' + repoName;
	
	// 모달을 일단 닫아준다.
	$('#addGitModal').modal('hide');
	
	// 해당 깃 정보로 저장소를 저장한다.
	$.ajax({
		url: getContextPath() + '/restapi/project/repositories',
		method: 'post',
		data : {
			'repo_url' :repo_url 
			,'repo_type' : 'git'
		},
		success: function(res) {
			if(res == "OK"){
				// 성공시 code 페이지 새로 불러온다.
				setTimeout(function(){
					movePageHistory('code');
				}, 500 )
			}
		},
		error: function(xhr, error, msg) {
		},
		dataType: 'json',
		async: false
	});
	
}

// 깃 저장소 연동 해지 메서드
const removeGitRepo = function(){
	
	// sweetAlert 버튼 초기화
	 swalWithBootstrapButtons = Swal.mixin({
		  customClass: {
			cancelButton: 'btn btn-light',
		   	confirmButton: 'btn btn-danger'
		  },
		  buttonsStyling: false
	})	
	
	swalWithBootstrapButtons.fire({
		  title: '정말로 Github 연동을 해지하겠습니까?',
		  text: "연동이 해지됩니다!",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonText: '해지',
		  cancelButtonText: '취소',
		  reverseButtons: true
		}).then((result) => {
		  if (result.isConfirmed) {
		    $.ajax({
				url : getContextPath() + '/restapi/project/repositories',
				method : 'post',
				data : {
					'repo_type' : 'git'
					,'_method' : 'delete'
				},
				success : function(res) {
					if(res == "OK"){
						swalWithBootstrapButtons.fire(
					      '성공!',
					      'Github Repository 와의 연동이 해지되었습니다.',
					      'success'
			  			)
						// 코드 페이지 새로 불러오기.
						movePageHistory('code');
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
};







