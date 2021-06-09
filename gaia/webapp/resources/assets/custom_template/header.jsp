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
<div class="nav-header ">
     <div class="brand-logo">
         <a href="#">
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
		<div class="header-left">
			<div class="input-group icons">
				<div class="input-group-prepend">
					<span class="input-group-text bg-transparent border-0 pr-2 pr-sm-3"
						id="basic-addon1"><i class="mdi mdi-magnify"></i></span>
				</div>
				<input type="search" class="form-control" placeholder="Search"
					aria-label="Search Dashboard">
				<div class="drop-down   d-md-none">
					<form action="#">
						<input type="text" class="form-control" placeholder="Search">
					</form>
				</div>
			</div>
		</div>
		<div class="header-right">
			<ul class="clearfix">
				<li class="icons dropdown">
					<jsp:include page="/WEB-INF/views/header/messenger.jsp"></jsp:include>
				</li>
<!------------------------ 	알람 드랍다운 시작 -->
				<li class="icons dropdown">
					<a href="javascript:void(0)" data-toggle="dropdown"> 
						<i class="mdi mdi-bell-outline"></i> 
						<span class="newAlarmCount badge badge-pill gradient-2 badge-primary">3</span>
					</a>
					<div class="drop-down animated fadeIn dropdown-menu position-fixed dropdown-notfication">
						<div class="dropdown-content-heading d-flex justify-content-between">
							<p class="newnotitag"><span class="newAlarmCount">2</span> New Notifications</p>
<!-- 							<span>2 New Notifications</span> -->
						</div>
						<div class="dropdown-content-body">
							<ul id="alarmList">
<!--  								알람 목록은 여기에 들어감 -->
							</ul>
						</div>
					</div>
				</li>
<!------------------------	알람 끝 -->
					<li class="icons dropdown d-none d-md-flex"><a
					href="javascript:void(0)" class="log-user" data-toggle="dropdown">
						<span>English</span> <i class="fa fa-angle-down f-s-14"
						aria-hidden="true"></i>
				</a>
					<div
						class="drop-down dropdown-language animated fadeIn  dropdown-menu">
						<div class="dropdown-content-body">
							<ul>
								<li><a href="javascript:void()">English</a></li>
								<li><a href="javascript:void()">한국어</a></li>
							</ul>
						</div>
					</div></li>
				<li class="icons dropdown">
					<div class="user-img c-pointer position-relative" data-toggle="dropdown">
						<span class="activity active"></span> 
						<img class="profile_img" height="40" width="40"alt="">
					</div>
					<div class="drop-down dropdown-profile   dropdown-menu">
						<div class="dropdown-content-body">
							<ul>
								<li><a href="#" class="moveButton" data-menu="overview"><i
										class="icon-user"></i> <span>Overview</span></a></li>
								<li><a href="#" class="moveButton" data-menu="setting"><i
										class="icon-user"></i> <span>Setting</span></a></li>
								<li>
									<a href="email-inbox.html">
										<i class="icon-envelope-open"></i> 
										<span>Inbox</span>
										<div class="badge gradient-3 badge-pill badge-primary">3</div>
									</a>
								</li>
								<hr class="my-2" />
								<li><a href="page-lock.html"><i class="icon-lock"></i>
										<span>Lock Screen</span></a></li>
								<li><a href="${cPath }/signout"><i class="icon-key"></i>
										<span>SIGN OUT</span></a></li>
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
				<i class="icon-bubbles"></i>
			</span>
			<div class="notification-content">
				<div class="notifi-cont notification-heading"></div>
				<span class="notifi-time notification-text"></span>
			</div>
		</a>
	</li>
<!-- 	알람 템플릿 끝 -->

</div>
