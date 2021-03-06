
$(function(){
	
	//////////////////////////////////////////////////////////////////////////////
	//
	//	 각종 버튼 바인딩
	//
	//////////////////////////////////////////////////////////////////////////////
	
	// 버튼 누르면 movePageHistory를 호출해 해당 버튼에 맞는 페이지로 매칭시켜줍니다.
	$('.nk-sidebar').on('click', '.moveButton', function(){
		event.preventDefault();
		let menuName = $(this).data('menu');
		movePageHistory(menuName);
	})
	
	// 상단 profile 메뉴에 대한 처리
	$('.header-fixed').on('click', '.moveButton', function(){
		event.preventDefault();
		let menuName = $(this).data('menu');
		memberMovePageHistory(menuName);
	})
	
	// 언어 선택 버튼에 대한 처리
	$('.languages').on('click', 'li', function(){
		let selectedLanguage = getKeyByValue(languages, $(this).children('a').text());
		selecteLanguage(selectedLanguage);
	})
	
	// 프로필 사진 클릭에 대한 처리
	$('body').on('click', '.profile', function(){
		// nonlink 클래스를 가졌을 경우 링크를 태우지 않음.
		if($(this).hasClass('nonlink')){
			return;
		}
		let src = $(this).attr('src');
		let user_no = src.substring(src.lastIndexOf('/')+1);
		// 사진 없어서 액박 떴을 경우 data 에서 받아온다.
		if(user_no == 'default'){
			user_no = $(this).data('mem_no');
		}
		loadPersonalPage(user_no);
	});
	
	// keyboard 단축키 바인딩.
	$(document).bind('keypress', function(e) {
		// 단축키 목록 보는 단축키 : ctrl + '/'
		let ctrl = e.ctrlKey;
		let shift = e.shiftKey;
		let key = e.which;
		if(ctrl && shift){
			switch(key){
				case 1 : movePageHistory('analytics'); break;
				case 14 : movePageHistory('news'); break;
				case 49 : movePageHistory('code'); break;
				case 51 : movePageHistory('milestone'); break;
				case 52 : movePageHistory('issue'); break;
				case 53 : movePageHistory('ganttchart'); break;
				case 30 : movePageHistory('calendar'); break;
				case 55 : movePageHistory('kanbanboard'); break;
				case 56 : movePageHistory('news'); break;
				case 57 : movePageHistory('wiki'); break;
				case 48 : movePageHistory('analytics'); break;
			}
			
		}else if(ctrl) {
			switch(key){
				case 7 : movePageHistory('ganttchart'); break;
				case 11 : movePageHistory('kanbanboard'); break;
				case 12 : movePageHistory('calendar'); break;
				case 13 : movePageHistory('milestone'); break;
				case 16 : movePageHistory('wiki'); break;
				case 21 : movePageHistory('issue'); break;
				case 47 :
					$('#shortcutModal').modal('toggle');
					break;
			}
		}
	});
	
	// 뒤로가기 이벤트 binding 하기
	$(window).bind("popstate", function(event) {
	    var data = event.originalEvent.state;
	    if(data){ // 이전 페이지 데이터가 있으면 ajax로 다시 요청해 화면 렌더링.
	    	if(data.startsWith('member-')){
				memberMovePage(data.substring('member-'.length));
			}else{
		    	movePage(data);
	    	}
	    }else{ // 히스토리에 정보가 없을경우 메인화면으로 이동시키기.
	    	var url = getContextPath();
	    	$(location).attr('href',url);
	    }
	})


	//////////////////////////////////////////////////////////////////////////////
	//
	//	 Document ready 됐을때 필요한 함수들
	//
	//////////////////////////////////////////////////////////////////////////////
	
	// ajax 로딩 관련 선언
	let loading = $('<div id="loading" class="loading"><img id="loading_img" alt="loading" src="'+getContextPath()+'/resources/images/loading/ajax-loader.gif" /></div>')
			.appendTo(document.body).hide();
	
	$(window).ajaxStart(function(){
		loading.show();
	}).ajaxStop(function(){
		loading.hide();
	});
	
})

//////////////////////////////////////////////////////////////////////////////
//
//	 각종 변수 선언
//
//////////////////////////////////////////////////////////////////////////////

const priorities = ['즉시','긴급','높음','보통','낮음','무시'];

const languages = {
	 'ENG' : 'English'
	,'KOR' : '한국어' 
	,'GER' : 'Deutsch'
	,'JAP' : '日本語' 
	,'CHI' : '中文' 
}

//////////////////////////////////////////////////////////////////////////////
//
//	 각종 함수 선언
//
//////////////////////////////////////////////////////////////////////////////

// ajaxError 설정
const ajaxError = function(xhr, error, msg){
	console.log(xhr);
	console.log(error);
	console.log(msg);
	if (xhr.status == 401) {
		toastr.error("세션이 만료되어 로그인 페이지로 이동합니다.");
		setTimeout(function() {
			window.location.href = "http://gaia.best";
		}, 2000);
	}else if(xhr.status == 423){
		toastr.error("해당 프로젝트에 접근할 수 있는 권한이 없습니다.");
	}
}

/**
	스트링 배열에서 이진법상 1로 등록된 스트링만 골라서 새로운 배열을 반환하는 함수
	사용 예 : function(6, ['철수', '영희', '민수'])
			 -> return ['철수', '영희']
 */ 
const getStringArrayFromBinaryAndArray = function(binary, array){
	let length = array.length;
	let binaryString = binary.toString(2).padStart(array.length,'0');
	let result = [];
	for(i=0; i<length; i++){
		if(binaryString.charAt(i) == '1')
			result.push(array[i]);
	}
	return result;
}

/**
	특정 태그의 hidden 상태를 토글 해 줍니다. hidden 상태의 tag가 parameter로 들어가면
	해당 태그의 hidden 상태가 없어지고, hidden이 아닌 태그가 들어가면 hidden 상태로 만들어줍니다.
 */
const toggleHidden = function(tag){
	tag.prop('hidden', !isHidden(tag));
}

/**
	특정 태그가 hidden 상태인지 확인해 줍니다.
 */
const isHidden = function(tag){
	return tag.prop('hidden');
}

// 쿠키 값 얻어오는 function
const getCookie = function(name) {
	let CookieValue = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return CookieValue? decodeURI(CookieValue[2]) : null;
};

// 쿠키 값 설정하는 function
const setCookie = function(name, value, exp){
	var date = new Date();
	date.setTime(date.getTime() + exp*24*60*60*1000);
	document.cookie = name+'='+escape(value)+';expires='+date.toUTCString()+';path=/';
}
	
// 현 URL에서 contextPath 빼고 구하는 function
const getCurrentUrl = function(){
	let hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring(hostIndex);
}

// 현 URL 에서 마지막 parameter 번호만 구해서 반환하는 function
const getUrlParameter = function(){
	let url = location.href;
	return url.substring(url.lastIndexOf('/')+1);
}

// 스크롤 맨 위로 올리는 함수
const scrollUp = function(){
	window.scrollTo({top:0, left:0, behavior:'auto'});
}

// 유저 프로필 사진 이름을 넣으면 경로를 반환 해주는 함수
const getProfilePath = function (filename) {
	return getContextPath() + '/resources/images/profiles/' + (filename==null ? 'default' : filename);
}
// 뉴스 사진 이름을 넣으면 경로를 반환 해주는 함수
const getNewsPath = function (filename) {
	return getContextPath() + '/resources/images/news/' + (filename==null ? 'default' : filename);
}

// 프로젝트 닉네임 쿠키에서 받아오기
const getProjNickFromCookie = function(){
	return getCookie('proj_user_nick');
} 
// 내 멤버 번호 쿠키에서 받아오기
const getMemNoFromCookie = function(){
	return getCookie('mem_no');
} 
// 쿠키에 있는 프로필 사진 파일명을 받아와 이미지 경로로 반환해주는 함수
const getProfilePathFromCookie = function(){
	return getProfilePath(getCookie('mem_pic_file_name'));
} 

// 한글 입력을 방지하는 함수 입니다.띄어쓰기도 막습니다.
// [selector].addEventListener('keyup', preventKorean); 형태로 사용합니다.
const preventKorean = function() {
	var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|\s]/;
	this.value = this.value.replace(pattern, '');
};

// value로 key 값 찾는 함수
const getKeyByValue = function(object, value) {
	return Object.keys(object).find(key => object[key] === value);
}

// 각종 nullChecking 모음. true = null | false = 값이 존. return
const CheckNullUndefined = function(value){
	return typeof value == 'string' && !value.trim() || typeof value == 'undefined' || value === null;
}

// 받침이 있는 문자인지 테스트 해주는 함수 입니다.
const isSingleCharacter = function(text) {
	var strGa = 44032; // 가
	var strHih = 55203; // 힣

	var lastStrCode = text.charCodeAt(text.length-1);

	if(lastStrCode < strGa || lastStrCode > strHih) {
		return false; //한글이 아닐 경우 false 반환
	}
	return (( lastStrCode - strGa ) % 28 == 0)
}

// '로' 가 붙어야 하는지 '으로'가 붙어야 하는지 체크해주는 함수
const roChecker = function(text){
	return text + (isSingleCharacter(text)? '로' : '으로'); 
}
// '를' 이 붙어야 하는지 '을'이 붙어야 하는지를 체크해주는 함수
const rulChecker = function(text){
	return text + (isSingleCharacter(text)? '를' : '을'); 
}

// \n 등을 <br> 태그로 바꿔서 반환해주는 함수
const toBrTag = function(str){
	return str? str.replace(/(?:\r\n|\r|\n)/g, '<br>') : '';
}

// 이미지 에러일 경우 default 이미지로 바꿔 주면서, mem_no는 data로 기록하도록 해주는 함수.
const imgOnErr = function(){
	let target = event.target;
	let target_mem_no = target.src.substring(target.src.lastIndexOf('/')+1);
	target.setAttribute('data-mem_no',target_mem_no);
	target.src = getProfilePath();
}

// json 으로 parse 가능한 string인지 체크하는 함수
const IsJsonString = function (str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

// DB 에서 메뉴에 대한 데이터를 받아와 화면에 출력해주는 함수 입니다.
const loadMenu = function(){
	
	// metismenu 가 이미 있을때 .metisMenu 가 먹히지 않아서 지운후 동적으로 재 생성 해주도록 했음.
	$('#projectsidebar').empty();
	$('#projectsidebar').append('<ul class="metismenu" id="menu"> </ul>');

	$.ajax({
		url : getContextPath() + '/restapi/project/menu',
		method : 'get',
		success : function(menulist) {
			
			let singlemenuTemplate = $('#sidebar-template').find('.singlemenu');
			let parentmenuTemplate = $('#sidebar-template').find('.parentmenu');
			let menus = [];
			$('#menu').empty();
			
			$.each(menulist, function(i,menu){
				let data = menu.MENU_DATA;
				let icon = menu.MENU_ICON;
				let parent = menu.MENU_PARENT;
				let setIndex = menu.MENU_SET_INDEX;
				let menucode = menu.MENU_CODE;
				
				// 언어 목록은 languages 객체에서 받아옵니다.
				let languageArea = $('#languages');
				languageArea.empty();
				languageArr = Object.values(languages);
				for (let i in languageArr ){
					// 언어 목록에 지원 가능한 언어 목록을 출력해준다.
					let langLi = '<li><a>'+languageArr[i]+'</a></li>';
					languageArea.append(langLi);
				}
				
				// 언어 설정에 cookie에 저장 되어 있으면 불러온다. 없으면 기본값 ENG
				let languageCookie = getCookie('language');
				let languageSetting = languageCookie ? languageCookie : 'ENG';
				
				// 언어 선택에 맞게 text 바꿔주고
				$('#currentLanguage').text(languages[languageSetting]);
				
				// data가 있으면 싱글메뉴, 없으면 parent menu 입니다.
				let menuBox = data ? singlemenuTemplate.clone() : parentmenuTemplate.clone();
				let menuBoxATag = menuBox.find('a');
				menuBoxATag.find('i').addClass(icon);
				menuBoxATag.attr('data-menu', data);
				menuBoxATag.attr('data-set_index', setIndex);
				
				// 언어 세팅에 맞게 메뉴명을 출력해준다. 
				menuBoxATag.find('span').text(eval('menu.MENU_NM_'+languageSetting));
				
				// 메뉴 식별을 위한 class를 추가해준다.
				menuBoxATag.addClass('menu-'+ menucode);
				
				// 부모 메뉴가 있는 경우에는 부모 메뉴의 ul에 append 한다.
				if(parent){
					let parentMenu = menus[menus.length-1];
					parentMenu.find('ul').append(menuBox);
				} else{
					// 부모메뉴가 없는 경우에는 menus에 push 한다.
					menus.push(menuBox);
				}
				
			})
			
			// 모든 메뉴를 담았으면 메뉴들을 출력해준다. 
			$('#menu').append(menus);
			
			// https://github.com/onokumus/metismenu 참고해서 발동. 기존의 custom.min.js에 있던건 주석 처리했음.
			$('#menu').metisMenu();
			
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
		,async : false
		
	})
	
}

// 언어 선택을 처리하는 함수
const selecteLanguage = function(selectedLanguage){
	//언어 선택시 쿠키에 저장하고
	setCookie('language', selectedLanguage, 30);
	// 메뉴 새로 불러준다.
	loadMenu();
};
		
		
		
// 개인별 페이지로 이동하게끔 해주는 함수		
const loadPersonalPage = function(user_no){
	
	// user_no 로 ajax 이용해 user_id 받아온 후 해당 페이지로 이동.
	$.ajax({
		url: getContextPath() + '/restapi/member/members/getMemIdFromMemNo.do',
		type: 'get',
		data: {
			'mem_no': user_no
		},
		success: function(mem_id) {
			history.pushState('member-' + 'personalPage', null, getContextPath() + '/' + mem_id);
			memberMovePage('personalPage')
		},
		error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'text'
	})
	
}
		
		
		
		
