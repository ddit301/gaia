<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div class="header-fixed">
<div class="nav-header" style="background: linear-gradient(to right, #acb6e5, #86fde8);">
     <div class="brand-logo">
         <a class="moveButton" data-menu="overview">
             <b class="logo-abbr"><img src="${cPath }/resources/assets/images/logo-text.png" alt=""> </b>
             <span class="logo-compact"><img src="${cPath }/resources/assets/images/logo-compact.png" alt=""></span>
             <span class="brand-title">
                 <img src="${cPath }/resources/assets/images/logo-text.png" alt="">
             </span>
         </a>
     </div>
 </div>
 
<div class="header">
	<div class="header-content clearfix">
		<div class="nav-control">
			<div class="hamburger">
				<span class="toggle-icon"><i class="icon-menu"></i></span>
			</div>
		</div>
		<div class="header-left header-left-custom">
			<div class="input-group icons">
				<div class="input-group-prepend">
					<span class="input-group-text bg-transparent border-0 pr-2 pr-sm-3"
						id="basic-addon1"><i class="mdi mdi-magnify"></i></span>
				</div>
				<input type="text" class="form-control dropdown-toggle total-search" placeholder="Search"
					aria-label="Search Dashboard" id="dropdownMenuSearchInput"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<div class="dropdown">
				  <div class="dropdown-menu total-search-dropdown" aria-labelledby="dropdownMenuSearchInput">
				    <a class="dropdown-item" href="#"><i class="icon-fire pr-2"></i>Issue</a>
				    <a class="dropdown-item" href="#"><i class="icon-direction pr-2"></i>Milestone</a>
				    <a class="dropdown-item" href="#"><i class="icon-doc pr-2"></i>Project</a>
				    <a class="dropdown-item" href="#"><i class="icon-cursor-move pr-2"></i>kanban</a>
				    <a class="dropdown-item" href="#"><i class="icon-graduation pr-2"></i>Wiki</a>
				    <a class="dropdown-item" href="#"><i class="icon-book-open pr-2"></i>News</a>
				    <a class="dropdown-item" href="#"><i class="icon-user pr-2"></i> Member</a>
				  </div>
				</div>
				
			</div>
		</div>
		<div class="header-right">
			<ul class="clearfix">
<!------------------------ 	알람 드랍다운 시작 -->
				<li class="icons dropdown">
					<a id="alarmIcon" href="javascript:void(0)" data-toggle="dropdown"> 
						<i class="mdi mdi-bell-outline"></i> 
						<span class="newAlarmCount badge badge-pill gradient-2 badge-primary"></span>
					</a>
					<div id="alarmDropdown" class="drop-down animated fadeIn dropdown-menu position-fixed dropdown-notfication">
						<div class="dropdown-content-heading d-flex justify-content-between">
							<span id="alarmHeader"></span>
							<button id="cleanAlarmBtn" class="btn btn-sm btn-rounded btn-outline-danger">CLEAN</button>
						</div>
						<div class="dropdown-content-body">
							<ul id="alarmList">
<!--  								알람 목록은 여기에 들어감 -->
							</ul>
						</div>
					</div>
				</li>
<!------------------------	알람 끝 -->
<!------------------------------------------ 언어 설정 시작 -->
					<li id="language-setting" class="icons dropdown d-none d-md-flex">
						<a data-toggle="dropdown">
							<span id="currentLanguage">English</span> 
							<i class="fa fa-angle-down f-s-14" aria-hidden="true"></i>
						</a>
					<div
						class="drop-down dropdown-language animated fadeIn  dropdown-menu">
						<div class="dropdown-content-body">
							<ul id="languages" class="languages">
								<li><a>English</a></li>
								<li><a>한국어</a></li>
							</ul>
						</div>
					</div></li>
<!------------------------------------------ 언어 설정 끝 -->
				<li class="icons dropdown">
					<div class="user-img c-pointer position-relative" data-toggle="dropdown">
						<span class="activity active"></span> 
						<img class="profile_img" onerror="imgOnErr()" height="40" width="40"alt="">
					</div>
					<div class="drop-down dropdown-profile dropdown-menu" style="font-size : 1.2em;">
						<div class="dropdown-content-body">
							<ul>
								<li><a class="moveButton" data-menu="overview"><i
										class="icon-user"></i> <span>Overview</span></a></li>
								<li><a class="moveButton" data-menu="setting"><i
										class="icon-settings"></i> <span>Setting</span></a></li>
								<li>
									<a class="moveButton" data-menu="chat">
										<i class="icon-envelope-open"></i> 
										<span>Inbox</span>
										<div class="badge gradient-3 badge-pill badge-primary">3</div>
									</a>
								</li>
								<hr class="my-2" />
								<li><a href="${cPath }/signout"><i class="icon-key"></i>
										<span style="color : black;">SIGN OUT</span></a></li>
							</ul>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>
</div>

<!-- 템플릿들 들어가는 자리  -->
<div id="headerTemplate">

<!-- 	알람 템플릿 시작 -->
	<li class="alarm">
		<a>
			<span class="mr-3 avatar-icon bg-success-lighten-1">
				<img class="alarmsender profile" alt="" onerror="this.src = getProfilePath()">
			</span>
			<div class="notification-content">
				<div class="notifi-cont notification-heading"></div>
				<span class="notifi-time notification-text"></span>
			</div>
		</a>
	</li>
<!-- 	알람 템플릿 끝 -->
<!--	통합 검색 템플릿 -->
	<div class="dropdown-menu total-search-dropdown" aria-labelledby="dropdownMenuSearchInput">
	    <a class="dropdown-item" href="#">TestText</a>
	</div>
</div>
