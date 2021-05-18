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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		// 뒤로가기 이벤트 binding 하기
		$(window).bind("popstate", function(event) {
		    var data = event.originalEvent.state;
		    if(data){ // 이전 페이지 데이터가 있으면 ajax로 다시 요청해 화면 렌더링.
		    	movePage(data);
		    }else{ // 히스토리에 정보가 없을경우 메인화면으로 이동시키기.
		    	var url = "${cPath}";    
		    	$(location).attr('href',url);
		    }
	 	})
	</script>
	<jsp:include page="/resources/quixlab/preScript.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="/resources/quixlab/preloader.jsp"></jsp:include>
    <div id="main-wrapper">
        <jsp:include page="/resources/quixlab/navheader.jsp"></jsp:include>
 		<jsp:include page="/resources/quixlab/header.jsp"></jsp:include>
 		<jsp:include page="/resources/quixlab/sidebar-project.jsp"></jsp:include>
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
        <jsp:include page="/resources/quixlab/footer.jsp"></jsp:include>
    </div>
	<jsp:include page="/resources/quixlab/postScript-project.jsp"></jsp:include>
</body>
</html>