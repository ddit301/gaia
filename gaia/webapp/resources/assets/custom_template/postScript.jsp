<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="${cPath }/resources/assets/plugins/common/common.min.js"></script>
    <script src="${cPath }/resources/assets/js/custom.min.js"></script>
    <script src="${cPath }/resources/assets/js/settings.js"></script>
    <script src="${cPath }/resources/assets/js/gleek.js"></script>
    <script src="${cPath }/resources/assets/js/styleSwitcher.js"></script>
	<script src="${cPath }/resources/js/moment.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/js/bootstrap-material-datetimepicker.min.js"></script>
	<script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.js"></script>	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="${cPath }/resources/js/jquery.serializejson.js"></script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="${cPath }/resources/js/jquery.validate.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.2/jquery.contextMenu.js" integrity="sha512-2ABKLSEpFs5+UK1Ol+CgAVuqwBCHBA0Im0w4oRCflK/n8PUVbSv5IY7WrKIxMynss9EKLVOn1HZ8U/H2ckimWg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.2/jquery.ui.position.js" integrity="sha512-vBR2rismjmjzdH54bB2Gx+xSe/17U0iHpJ1gkyucuqlTeq+Q8zwL8aJDIfhQtnWMVbEKMzF00pmFjc9IPjzR7w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/javascript">
	let project_title = '${project_title}';
	let manager_nick = '${manager_nick}';
	
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
	
	var data = {}
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
  
  // 쿠키 값 얻어오는 function
	var getCookie = function(name) {
		let CookieValue = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		return CookieValue? decodeURI(CookieValue[2]) : null;
	};
	
	// 접속 회원의 프로젝트 내 닉네임 입니다. 글 작성시 활용해주세요.
	// 일단 다른 페이지들에서 해당 변수 못쓰게 const 로 막고, 추후 프로필 데이터 변경 고려해 코드 완성 단계에 let 으로 풀겠습니다. 
	const proj_user_nick = getCookie('proj_user_nick');
	const mem_pic_file_name = getCookie('mem_pic_file_name');
	const mem_nick = getCookie('mem_nick');
	$('.user-img').children('img').attr('src', getProfilePath(mem_pic_file_name));
  
	// toastr 알람 설정
	toastr.options = {
			  "closeButton": false,
			  "debug": false,
			  "newestOnTop": false,
			  "progressBar": false,
			  "positionClass": "toast-top-right",
			  "preventDuplicates": false,
			  "onclick": null,
			  "showDuration": "100",
			  "hideDuration": "1000",
			  "timeOut": "1500",
			  "extendedTimeOut": "1000",
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut"
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
		    	}else{
			    	movePage(data);
		    	}
		    }else{ // 히스토리에 정보가 없을경우 메인화면으로 이동시키기.
		    	var url = "${cPath}";
		    	$(location).attr('href',url);
		    }
	 	})
	 	
	 	
		/*
		*	issueView, milestoneView, newIssue는 URL을 타고 들어올 수도 있으니 반드시 postScript에 있어야 합니다.
		*/
	 	
	 	var newIssue = function(){
			window.scrollTo({top:0, left:0, behavior:'auto'});
			
			data = 'newIssue'
			title = '';
			url = '${cPath}/${manager_nick}/${project_title}/issue/new'
			history.pushState(data, title, url);
			
			$.ajax({
				url : '${cPath}/view/project/newissue'
				,type : 'get'
				,success : function(res){
					$('.content-body').html(res);
				}
				,error : function(xhr){
					alert('error : ' + xhr.status);
				},
				dataType : 'html'
			})
		}
	 	
	 	var issueView = function(issue_no){
			window.scrollTo({top:0, left:0, behavior:'auto'});
			
			data = 'issueView'+issue_no;
			title = '';
			url = '${cPath}/${manager_nick}/${project_title}/issue/'+issue_no;
			history.pushState(data, title, url);
			
			$.ajax({
				url : '${cPath}/view/project/issueview'
				,type : 'get'
				,data : {
					'issue_no' : issue_no
					}
				,success : function(res){
					$('.content-body').html(res);
				}
				,error : function(xhr){
					alert('error : ' + xhr.status);
				},
				dataType : 'html'
			})
		}
	 	
		// milestoneView
		var milestoneView = function(milest_no){
			window.scrollTo({top:0, left:0, behavior:'auto'});
			
			let project_title = '${project_title}';
			let manager_nick = '${manager_nick}';
			
			data = 'milestoneView'+milest_no;
			title = '';
			url = '${cPath}/${manager_nick}/${project_title}/milestone/'+milest_no;
			history.pushState(data,title,url);
			
			$.ajax({
				url : '${cPath}/view/project/milestoneview'
				,type : 'get'
				,data : {
					'manager_nick' : manager_nick
					,'project_title' : project_title
					,'milest_no' : milest_no
					}
				,success : function(res) {
					$('.content-body').html(res);
				}
				,error : function(xhr){
					alert('error : ' + xhr.status);
				},
				dataType : 'html'
			})
		}
	 	
		// 뒤로가기 상황을 제외하고는 pushState를 통해 데이터를 쌓아야합니다.
		var movePageHistory = function(pageParam){
			var data = pageParam;
			var title;
			var url = getContextPath() + '/${manager_nick}/${project_title}'+ (pageParam ? '/'+pageParam : '') ;
			history.pushState(data, title, url);
			movePage(pageParam);
		}
		
		// 뒤로가기 상황에서는 movePage 함수를 바로 호출합니다. 그렇지 않으면 history가 꼬이게 됩니다.
		var movePage = function(pageParam){
			// project 페이지에서는 vertical로만 보여줍니다.
			new quixSettings({
			    layout: "vertical" // vertical or horizontal
			});
			
			// 화면 위로 올리기
			window.scrollTo({top:0, left:0, behavior:'auto'});
			
			let project_title = '${project_title}';
			let manager_nick = '${manager_nick}';
			if(!pageParam)
				pageParam = 'code';
			
			$.ajax({
				url : '${cPath}/view/project/'+pageParam,
				type : 'get',
				data : {'manager_nick' : manager_nick,'project_title' : project_title
					},
				success : function(res) {
					$('.content-body').html(res);
				},
				error : function(xhr) {
					// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
					if(xhr.status == '404')
						alert('등록되지 않는 버튼 : ' + pageParam);				
					ajaxError(xhr, error, msg);
				},
				dataType : 'html'
			})
		}
		
		var movePageHistoryMember = function(pageParam){
			var data = pageParam;
			var title;
			var url = getContextPath() +'/' + mem_nick + '/' +pageParam;
			history.pushState(data, title, url);
			movePageMember(pageParam);
		}
		
		var movePageMember = function(pageParam){
			let path = getContextPath()+"/view/member/";
			// member 페이지에서는 horizontal로만 보여줍니다.
			new quixSettings({
			    layout: "horizontal" // vertical or horizontal
			});
			// sideBar와 햄버거 메뉴를 숨깁니다 - project에 종속되기 떄문.
			$('.nk-sidebar').prop('hidden','true');
			$('.nav-control').prop('hidden','true');
			
			let index
			
			if(!pageParam){
				pageParam = 'overview';	
			}
			// setting으로 요청이 들어오면 profile로 변경시키기.(setting/profile -> setting으로만 표시 )
			if(pageParam=="setting"){
				pageParam = 'profile';	
			}
			// profile.jsp에서 'setting/account'로 pageParam을 넘김.
			if(pageParam.includes("/"))
				index = pageParam.indexOf("/");
				pageParam = pageParam.slice(index+1);
			
			$.ajax({
				url : path+pageParam ,
				type : 'get',
				data : {'mem_nick' : mem_nick
					},
				success : function(res) {
					$('.content-body').html(res);
				},
				error : function(xhr) {
					// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
					if(xhr.status == '404'){
						alert('등록되지 않는 버튼 : ' + pageParam);				
					}else{
						alert("status : " + xhr.status);
					}
				},
				dataType : 'html'
			})
		}
	 	
	 	/********************************************************************
	 	*
 		*	When document is ready
 		*		문서가 준비되고 나서 호출되어야 하는 함수들은 아래 기재합니다.
 		*	
 		*********************************************************************/
		$(function(){
			
			// 버튼 누르면 movePageHistory를 호출해 해당 버튼에 맞는 페이지로 매칭시켜줍니다.
			$('.nk-sidebar').on('click', '.moveButton', function(){
				event.preventDefault();
				let menuName = $(this).data('menu');
				movePageHistory(menuName);
			})
			
			// 우측 상단 profile 관련 메뉴에 대한 처리
			$('.dropdown-profile').on('click', '.moveButton', function(){
				event.preventDefault();
				let menuName = $(this).data('menu');
				movePageHistoryMember(menuName);
			})
			
		 	// 클릭 이벤트가 아닌 url을 직접 입력해서 페이지를 호출했을 경우에는 해당 이벤트를 통해 매칭시켜줍니다.	
			let pageParam = '${pageParam}';
			let issue_no = '${issue_no}';
			let milest_no = '${milest_no}';
			if(issue_no){
				if(issue_no == 'new'){
					newIssue();
				}else{
					issueView(issue_no);
				}
			}else if(milest_no){
				milestoneView(milest_no);
			}else{
				if(pageParam == 'overview' || pageParam=='setting'){
					movePageHistoryMember(pageParam);
				}
				movePageHistory(pageParam);
			}
		
		})
		/********************************************************************
	 	*
 		*	END OF 'When document is ready '
 		*	
 		*********************************************************************/
	</script>
    

