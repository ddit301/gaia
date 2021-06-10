

//////////////////////////////////////////////////////////////////////////////
//
//	 각종 함수 선언
//
//////////////////////////////////////////////////////////////////////////////

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
			window.location.href = getContextPath()
		}, 2000);
	}
}

// 쿠키 값 얻어오는 function
var getCookie = function(name) {
	let CookieValue = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return CookieValue? decodeURI(CookieValue[2]) : null;
};
	
// 현 URL에서 contextPath 빼고 구하는 function
var getCurrentUrl = function(){
	let hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring(hostIndex);
}

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
		
