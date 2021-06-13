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
		if (type == 'dir') {
			loadFilesFromGit(gitRepoUrl, path);
		}else{
		}
	})

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
			,
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

	$.ajax({
		url: getContextPath() + '/restapi/project/repositories',
		method: 'get',
		success: function(res) {
			$.each(res, function(i, v) {
				// git 저장소가 있으면 loadGit 함수를 호출한다.
				if (v.REPO_TYPE == 'git') {
					gitRepoUrl = v.REPO_URL;
					$('.git').find('.repoHeader').children('span').text(gitRepoUrl);
					loadGit(gitRepoUrl);
					// svn 관련 데이터는 아직 미구현		
					//				}else if(v.repo_type == 'svn'){
					//					loadSvn(v);
				}
			})
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

//////////////////////////////////////////////////////////////////////////////
//
//	 gitHub restAPI 활용
//
//////////////////////////////////////////////////////////////////////////////

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
		error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
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
		},
		error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType: 'html',
	});
}

const loadFilesFromGit = function(gitRepoUrl, path) {
	$.ajax({
		url: 'https://api.github.com/repos/' + gitRepoUrl + '/contents' + (path ? '/' + path : ''),
		method: 'get',
		success: function(contents) {
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
				filenameElement.attr('href', file.html_url);
				if (file.type == 'file')
					filenameElement.attr('data-download_url', file.download_url);

				// 파일인지 폴더인지에 따라 각각의 배열에 push 한다.
				(file.type == 'file' ? files : folders).push(fileBox);
			})

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
			}
			// 폴더 - 파일 순으로 출력 해 준다.
			fileNavBody.append(folders);
			fileNavBody.append(files);
		},
		error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType: 'json',
		async: false
	});
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

