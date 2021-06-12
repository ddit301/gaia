// 프로젝트에 속한 저장소들을 불러오는 함수
const loadRepositoryList = function(){
	
	$.ajax({
		url : getContextPath() + '/restapi/project/repositories',
		method : 'get',
		success : function(res) {
			$.each(res, function(i,v){
				// git 저장소가 있으면 loadGit 함수를 호출한다.
				if(v.REPO_TYPE == 'git'){
					loadGit(v);		
				// svn 관련 데이터는 아직 미구현		
//				}else if(v.repo_type == 'svn'){
//					loadSvn(v);
				}
			})
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
	
	
}

// git 저장소가 있을 경우 해당 정보를 화면에 출력해줍니다.
const loadGit = function(repository){
	// #readmeArea를 뷰어로 변경하고
	viewer = toastui.Editor.factory({
	     el: document.querySelector('#readmeArea')
	     ,height : 'auto'
	     ,viewer : true
	   });
	// repo 주소에서 readme를 받아와 화면에 출력해줍니다.
	let readmeMd = readmeFromRepo(repository.REPO_URL); 
	viewer.setMarkdown(readmeMd);
}

//////////////////////////////////////////////////////////////////////////////
//
//	 gitHub restAPI 활용
//
//////////////////////////////////////////////////////////////////////////////

// 특정 github 저장소에서 readme 파일을 불러오는 함수
// url 형식은 ddit301/gaia 처럼 아이디/프로젝트 가 들어가면 됩니다.
const readmeFromRepo = function(url){
	let decoded;
	$.ajax({
		url : 'https://api.github.com/repos/'+url+'/readme',
		method : 'get',
		success : function(res) {
			decoded = Base64.decode(res.content);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json',
		async : false
	});
	return decoded;
}

// 마크다운으로 작성된 text를 html 으로 렌더링 해주는 함수
const renderMarkdown = function(text){
	$.ajax({
		url : 'https://api.github.com/markdown',
		method : 'post',
		data : JSON.stringify({"text" : text}),
		success : function(res) {
			$('#testGit').append(res);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'html',
	});
}