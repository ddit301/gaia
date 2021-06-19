<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="nk-sidebar" style="position: fixed;">           
    <div id="projectsidebar" class="nk-nav-scroll">
<!--      metismenu 가 이미 있을때 $('#menu').metisMenu(); 가 먹히지 않아서 지운후 동적으로 재 생성 해주도록 했음. -->
<!--         <ul class="metismenu" id="menu"> -->
<!--         </ul> -->
    </div>
</div>

<div id="sidebar-template" hidden="true">

<!-- 	일반 메뉴 템플릿 -->
	<li class="singlemenu">
	    <a class="moveButton codemenu" data-menu="code" >
	        <i></i>
	        <span class="nav-text"></span>
	    </a>
	</li>
<!-- 	일반 메뉴 템플릿 끝 -->

<!-- 	확장형 메뉴 템플릿 -->
    <li class="parentmenu">
        <a class="has-arrow">
            <i></i>
            <span class="nav-text"></span>
        </a>
        <ul>
        </ul>
    </li>
<!-- 	확장형 메뉴 템플릿 끝-->

</div>
        
