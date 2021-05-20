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
<script type="text/javascript">
	var overview = function(){
		$.ajax({
			url : '${cPath}/view/project/overview',
			type : 'get',
			success : function(res) {
				$('.content-body').html(res);
				var overviewData = '조회중인 프로젝트 생성자 : ${mem_nick }<br/>'
					+'조회중인 프로젝트 타이틀 : ${project_title }'
				$('.container-fluid').html(overviewData);
					
			},
			error : function(xhr) {
				alert("status : " + xhr.status);
			},
			dataType : 'html'
		})
	}
	var milestone = function(){
		$.ajax({
			url : '${cPath}/view/project/milestone',
			type : 'get',
			success : function(res) {
				$('.content-body').html(res);
				
			},
			error : function(xhr) {
				alert("status : " + xhr.status);
			},
			dataType : 'html'
		})
	}
	var issue = function(){
		$.ajax({
			url : '${cPath}/view/project/issue',
			type : 'get',
			success : function(res) {
				$('.content-body').html(res);

			},
			error : function(xhr) {
				alert("status : " + xhr.status);
			},
			dataType : 'html'
		})
	}
	
	// 
	var movePageHistroy = function(pageParam){
		var data = pageParam;
		var title;
		var url = '${cPath}/${mem_nick }/${project_title }/'+pageParam;
		history.pushState(data, title, url);
		
		movePage(pageParam);
	}
	
	var movePage = function(pageParam){
		switch(pageParam){
			case 'overview' : 
				overview();
				break;
			case 'issue' : 
				issue();
				break;
			case 'milestone' : 
				milestone();
				break;
			default:
				alert(pageParam + '는 유효하지 않은 명령');
		}
	}
</script>
<script>
<c:if test="${not empty projectMenu }" >
	let pageParam = '${projectMenu}'; 
	movePageHistroy(pageParam);
</c:if>
</script>
 <div class="nk-sidebar">           
	<div class="nk-nav-scroll">
	    <ul class="metismenu" id="menu">
	        <li class="nav-label">Dashboard</li>
	        <li>
	            <a class="has-arrow" href="javascript:void()" aria-expanded="false">
	                <i class="icon-speedometer menu-icon"></i><span class="nav-text">Overview</span>
	            </a>
	        </li>
	        <li>
	            <a class="has-arrow" href="javascript:void()" aria-expanded="false">
	                <i class="icon-envelope menu-icon"></i> <span class="nav-text">Help</span>
	            </a>
	        </li>
	        <li>
	            <a class="has-arrow" href="javascript:void()" aria-expanded="false">
	                <i class="icon-envelope menu-icon"></i> <span class="nav-text">Settings</span>
	            </a>
	            <ul aria-expanded="false">
	                <li><a href="#">activity</a></li>
	                <li><a href="#">new</a></li>
	            </ul>
	        </li>
	    </ul>
	</div>
</div>