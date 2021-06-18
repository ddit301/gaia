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
  <div class="nk-sidebar" style="position: fixed;">           
            <div class="nk-nav-scroll">
                <ul class="metismenu" id="menu">
                    <li>
                        <a class="moveButton codemenu" data-menu="code" aria-expanded="false">
                            <i class="icon-screen-desktop"></i><span class="nav-text">Code</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="milestone" aria-expanded="false">
                            <i class="icon-directions"></i><span class="nav-text">Milestone</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="issue" aria-expanded="false">
                            <i class="icon-fire"></i><span class="nav-text">Issue</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="ganttchart" aria-expanded="false">
                            <i class="icon-chart"></i><span class="nav-text">Gantt</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="calendar" aria-expanded="false">
                            <i class="icon-calender"></i><span class="nav-text">Calendar</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="kanbanboard" aria-expanded="false">
                            <i class="icon-cursor-move"></i><span class="nav-text">Kanban</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="cloud" aria-expanded="false">
                            <i class="icon-cloud-download"></i><span class="nav-text">Cloud</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="news" aria-expanded="false">
                            <i class="icon-book-open"></i><span class="nav-text">News</span>
                        </a>
                    </li>
                    <li>
                        <a class="moveButton" data-menu="wiki" aria-expanded="false">
                            <i class="icon-graduation menu-icon"></i><span class="nav-text">Wiki</span>
                        </a>
                    </li>
                    <li>
                        <a id="sideSettingMenu" class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-menu menu-icon"></i><span class="nav-text">Setting</span>
                        </a>
                        <ul aria-expanded="false">
                            <li>
                               <a class="moveButton" data-menu="member"  >
                           		 <i class="icon-user menu-icon"></i> <span class="nav-text">Member</span>
                    		   </a>
                            </li>
                            <li>
                               <a class="moveButton managementmenu" data-menu="management"  >
                           		 <i class="icon-settings menu-icon"></i> <span class="nav-text">Management</span>
                    		   </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        
