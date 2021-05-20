<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
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
    <jsp:include page="/resources/assets/custom_template/preloader.jsp"></jsp:include>
    <div id="main-wrapper">
        <jsp:include page="/resources/assets/custom_template/navheader.jsp"></jsp:include>
 		<jsp:include page="/resources/assets/custom_template/header.jsp"></jsp:include>
 		<jsp:include page="/resources/assets/custom_template/sidebar-project.jsp"></jsp:include>
        <!--**********************************
            Content body start
        ***********************************-->
		<div class="content-body"></div>
        <!--**********************************
            Content body end
        ***********************************-->
        <jsp:include page="/resources/assets/custom_template/footer.jsp"></jsp:include>
    </div>
	<jsp:include page="/resources/assets/custom_template/postScript.jsp"></jsp:include>
</body>
</html>
