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
<script type="text/javascript">

	// 뒤로가기 상황을 제외하고는 pushState를 통해 데이터를 쌓아야합니다.
	var movePageHistory = function(pageParam){
		var data = pageParam;
		var title;
		var url = '${cPath}/${manager_nick }/${project_title }/'+pageParam;
		history.pushState(data, title, url);
		movePage(pageParam);
	}
	
	// 뒤로가기 상황에서는 movePage 함수를 바로 호출합니다. 그렇지 않으면 history가 꼬이게 됩니다.
	var movePage = function(pageParam){
		let project_title = '${project_title}';
		let manager_nick = '${manager_nick}';
		
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
                    <li>
                        <a class="moveButton" data-menu="overview" href="#" aria-expanded="false">
                            <i class="icon-home menu-icon"></i><span class="nav-text">Overview</span>
                        </a>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-docs menu-icon"></i><span class="nav-text">Projects</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href=".">다른프로젝트1</a></li>
                            <li><a href=".">다른프로젝트2</a></li>
                            <li><a href=".">다른프로젝트3</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="milestone" href="#" aria-expanded="false">
                            <i class="icon-directions"></i><span class="nav-text">Milestone</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="issue" href="#" aria-expanded="false">
                            <i class="icon-fire"></i><span class="nav-text">Issue</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="ganttchart" href="#" aria-expanded="false">
                            <i class="icon-chart"></i><span class="nav-text">Gantt</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="calendar" href="#" aria-expanded="false">
                            <i class="icon-calender"></i><span class="nav-text">Calendar</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="kanbanboard" href="#" aria-expanded="false">
                            <i class="icon-cursor-move"></i><span class="nav-text">Kanban</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="code" href="#" aria-expanded="false">
                            <i class="icon-screen-desktop"></i><span class="nav-text">Code</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="news" href="#" aria-expanded="false">
                            <i class="icon-book-open"></i><span class="nav-text">News</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="wiki" href="#" aria-expanded="false">
                            <i class="icon-graduation menu-icon"></i><span class="nav-text">Wiki</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="messenger" href="#" aria-expanded="false">
                            <i class="icon-speech menu-icon"></i><span class="nav-text">Messenger</span>
                        </a>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-graph menu-icon"></i> <span class="nav-text">Analytics</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a class="moveButton" href="#">Flot</a></li>
                            <li><a class="moveButton" href="#">Morris</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-menu menu-icon"></i><span class="nav-text">Setting</span>
                        </a>
                        <ul aria-expanded="false">
                            <li>
                               <a class="moveButton" data-menu="setting-member" href="#">
                           		 <i class="icon-user menu-icon"></i> <span class="nav-text">Member</span>
                    		   </a>
                            </li>
                            <li>
                               <a class="moveButton" data-menu="setting-management" href="#">
                           		 <i class="icon-settings menu-icon"></i> <span class="nav-text">Management</span>
                    		   </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>