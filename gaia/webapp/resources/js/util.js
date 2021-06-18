
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
		$('.metismenu').find('a').removeClass('selectedMenu');
		$(this).addClass('selectedMenu');
		movePageHistory(menuName);
	})
	
	// 우측 상단 profile 관련 메뉴에 대한 처리
	$('.dropdown-profile').on('click', '.moveButton', function(){
		event.preventDefault();
		let menuName = $(this).data('menu');
		memberMovePageHistory(menuName);
	})
	
	
	//////////////////////////////////////////////////////////////////////////////
	//
	//	 Document ready 됐을때 필요한 함수들
	//
	//////////////////////////////////////////////////////////////////////////////
	
	// ajax 로딩 관련 선언
	let loading = $('<div id="loading" class="loading"><img id="loading_img" alt="loading" src="/resources/images/loading/ajax-loader.gif" /></div>')
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

//////////////////////////////////////////////////////////////////////////////
//
//	 각종 함수 선언
//
//////////////////////////////////////////////////////////////////////////////

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

// 뒤로가기 이벤트 binding 하기
$(window).bind("popstate", function(event) {
    var data = event.originalEvent.state;
    if(data){ // 이전 페이지 데이터가 있으면 ajax로 다시 요청해 화면 렌더링.
    	if(data.startsWith("issueView")){
    		let issue_no = data.substring("issueView".length);
    		issueView(issue_no);
    	}else if(data == 'newIssue'){
    		newIssue();
    	}else if(data.startsWith("milestoneView")){
    		let milest_no = data.substring("milestoneView".length);
    		milestoneView(milest_no);
    	}else if(data.startsWith('member-')){
			memberMovePage(data.substring('member-'.length));
		}else{
	    	movePage(data);
    	}
    }else{ // 히스토리에 정보가 없을경우 메인화면으로 이동시키기.
    	var url = getContextPath();
    	$(location).attr('href',url);
    }
})

// ajaxError 설정
function ajaxError(xhr, error, msg){
	console.log(xhr);
	console.log(error);
	console.log(msg);
	if (xhr.status == 401) {
		toastr.error("세션이 만료되어 로그인 페이지로 이동합니다.");
		setTimeout(function() {
			window.location.href = "/";
		}, 2000);
	}
}

// 쿠키 값 얻어오는 function
const getCookie = function(name) {
	let CookieValue = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return CookieValue? decodeURI(CookieValue[2]) : null;
};
	
// 현 URL에서 contextPath 빼고 구하는 function
const getCurrentUrl = function(){
	let hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring(hostIndex);
}

// 스크롤 맨 위로 올리는 함수
const scrollUp = function(){
	window.scrollTo({top:0, left:0, behavior:'auto'});
}

// 유저 프로필 사진 이름을 넣으면 경로를 반환 해주는 함수
const getProfilePath = function (filename) {
	return getContextPath() + '/resources/images/profiles/' + (filename==null ? 'default' : filename);
}

// 프로젝트 닉네임 쿠키에서 받아오기
const getProjNickFromCookie = function(){
	return getCookie('proj_user_nick');
} 

// 한글 입력을 방지하는 함수 입니다.띄어쓰기도 막습니다.
// [selector].addEventListener('keyup', preventKorean); 형태로 사용합니다.
const preventKorean = function() {
  var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|\s]/;
  this.value = this.value.replace(pattern, '');
};

//////////////////////////////////////////////////////////////////////////////
//
//	 각종 설정
//
//////////////////////////////////////////////////////////////////////////////

// toastr 알람 설정
toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": true,
		  "positionClass": "toast-top-right",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "100",
		  "hideDuration": "1000",
		  "timeOut": "2000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}
		
// Swal Alert 설정
var swal = {
	error : function(data){
		console.log(data);
		if(!data){data = { };}
		Swal.fire({
			icon: 'error',
			title: typeof data.title !=='undefined' ? data.title : 'Oops...', 
			text: !!data.text ? data.text : 'Something went wrong!',
			showConfirmButton : !!data.confirm ? true : false,
			timer: 1500
		})
	},
	success : function(data){
		if(!data){data = { };}
			Swal.fire({
				icon: 'success',
				title: !!data.title ? data.title : 'Success!!',
				text: !!data.text ? data.text : 'Your work has been saved!',
				showConfirmButton : !!data.confirm ? true : false,
				timer: 1500
			})
	},
	warning : function(data){
		if(!data){data = { };}
		Swal.fire({
			icon: 'warning',
			title: !!data.title ? data.title : 'Oops...', 
			text: !!data.text ? data.text : 'You should do someting first!',
			showConfirmButton : !!data.confirm ? true : false,
			timer: 1500
		})
	},
	info : function(data){
		if(!data){data = { };}
		Swal.fire({
			icon: 'info',
			title: !!data.title ? data.title : 'Have to know!', 
			text: !!data.text ? data.text : 'blablabla',
			showConfirmButton : !!data.confirm ? true : false,
			timer: 1500
		})
	}
}
		
