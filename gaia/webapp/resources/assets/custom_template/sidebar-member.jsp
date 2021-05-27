<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${cPath }/resources/assets/css/member.css" rel="stylesheet">
<script type="text/javascript">
	// 뒤로가기 상황을 제외하고는 pushState를 통해 데이터를 쌓아야합니다.
	var movePageHistory = function(pageParam){
		var data = pageParam;
		var title;
		// 이게 주소창에 찍히는 녀석임.
		// var url = '${cPath}/${mem_nick }'+ 'aa';
		var url = getContextPath() + '/${mem_nick }'+(pageParam ? '/'+pageParam : '');
		console.log(data);
		history.pushState(data, title, url);
		movePage(pageParam);
	}
	
	// 뒤로가기 상황에서는 movePage 함수를 바로 호출합니다. 그렇지 않으면 history가 꼬이게 됩니다.
	var movePage = function(pageParam){
		let mem_nick = '${mem_nick}';
		let path = getContextPath()+"/view/member/";
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
	
</script>
 <div class="nk-sidebar">           
	<div class="nk-nav-scroll">
	    <ul class="metismenu" id="menu">
	        <li class="nav-label">Dashboard</li>
	        <li>
	            <a class="moveButton" href="javascript:void()" aria-expanded="false">
	                <i class="icon-speedometer menu-icon"></i><span class="nav-text">Overview</span>
	            </a>
	        </li>
	        <li>
	            <a class="moveButton" href="javascript:void()" aria-expanded="false">
	                <i class="icon-envelope menu-icon"></i> <span class="nav-text">Help</span>
	            </a>
	            <ul aria-expanded="false">
	                <li><a class="moveButton" data-menu="help-contact" href="javascript:void()" >contact</a></li>
	                <li><a class="moveButton" data-menu="help-FAQ" href="javascript:void()">FAQ</a></li>
	                <li><a class="moveButton" data-menu="help-notice" href="javascript:void()">notice</a></li>
	            </ul>
	        </li>
	        <li>
	            <a class="moveButton" data-menu="setting" href="javascript:void()" aria-expanded="false">
	                <i class="icon-envelope menu-icon"></i> <span class="nav-text">Setting</span>
	            </a>
	        </li>
	    </ul>
	</div>
</div>