<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/quixlab/preScript.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="/quixlab/preloader.jsp"></jsp:include>
    <div id="main-wrapper">
        <jsp:include page="/quixlab/navheader.jsp"></jsp:include>
 		<jsp:include page="/quixlab/header.jsp"></jsp:include>
 		<jsp:include page="/quixlab/sidebar-project.jsp"></jsp:include>
        <!--**********************************
            Content body start
        ***********************************-->
    <%
	Cookie[] cookies = request.getCookies();
	String loginId = "";
	String loginName = "";
	if(cookies != null){
		for(Cookie tmp : cookies){
			String value = URLDecoder.decode(tmp.getValue(),"utf-8");
			if("loginId".equals(tmp.getName())){
				loginId = URLDecoder.decode(tmp.getValue(),"utf-8");
			}
			if("loginName".equals(tmp.getName())){
				loginName = URLDecoder.decode(tmp.getValue(),"utf-8");
			}
		}
	}
	pageContext.setAttribute("loginName", loginName);
	pageContext.setAttribute("loginId", loginId);
	%>
		<div class="content-body">
			
		</div>
        <!--**********************************
            Content body end
        ***********************************-->
        <jsp:include page="/quixlab/footer.jsp"></jsp:include>
    </div>
	<jsp:include page="/quixlab/postScript-project.jsp"></jsp:include>
</body>
</html>