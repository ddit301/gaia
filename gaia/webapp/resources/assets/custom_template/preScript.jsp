<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>gaia</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="${cPath }/resources/main/images/favicons/favicon-16x16.png">
    <!-- Custom Stylesheet -->
    <link href="${cPath }/resources/assets/css/style.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/plugins/nestable/css/nestable.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-3YZPKG0D0K"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	  gtag('config', 'G-3YZPKG0D0K');
	  
	function getContextPath() {
   		return "<%=request.getContextPath()%>";
	}
	
	</script>
	
