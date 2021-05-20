<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 18, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <jsp:include page="/resources/assets/custom_template/preScript.jsp"></jsp:include>
</head>
<body>
<!-- Preloader start -->
<div id="preloader">
    <div class="loader">
        <svg class="circular" viewBox="25 25 50 50">
            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
        </svg>
    </div>
</div>
<div id="main-wrapper">
	<jsp:include page="/resources/assets/custom_template/navheader.jsp"></jsp:include>
	<jsp:include page="/resources/assets/custom_template/header.jsp"></jsp:include>
	<jsp:include page="/resources/assets/custom_template/sidebar-member.jsp"></jsp:include>
	<div class="row page-titles mx-0">
	    <div class="col p-md-0">
	        <ol class="breadcrumb">
	            <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
	            <li class="breadcrumb-item active"><a class="moveButton" data-menu="${pageParam}" href="javascript:void(0)">${pageParam}</a></li>
	        </ol>
	    </div>
	</div>
	<div class="content-body">
	     
	</div>
	<jsp:include page="/resources/assets/custom_template/footer.jsp"></jsp:include>
</div>
<jsp:include page="/resources/assets/custom_template/postScript.jsp"></jsp:include>
</body>
</html>