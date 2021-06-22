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
<!--     Common css -->
    <link href="${cPath }/resources/assets/css/style.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/common.css" rel="stylesheet">
    <!-- Custom Stylesheet -->
    <link href="${cPath }/resources/assets/css/member.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/alarm.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/chat.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/code.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/issue.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/news.css" rel="stylesheet">
<!--     kanbaj css -->
    <link href="${cPath }/resources/assets/dist/jkanban.min.css" rel="stylesheet" >
    <link href="${cPath }/resources/assets/css/kanban.css" rel="stylesheet">
    <!-- DateTimePicker Stylesheet-->
    <link href="${cPath }/resources/assets/css/external/material-icon.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/external/bootstrap-material-datetimepicker.min.css" rel="stylesheet">
    <!-- Toast UI Stylesheets -->
    <link href="${cPath }/resources/assets/css/external/codemirror.min.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/external/toastui-editor.min.css" rel="stylesheet">
    <link href="${cPath }/resources/assets/css/external/tui-color-picker.css" rel="stylesheet">
    <!-- Toastr Stylesheet -->
    <link href="${cPath }/resources/assets/css/external/toastr.css" rel="stylesheet">
    <!-- jquery-contextmenu -->
    <link href="${cPath }/resources/assets/css/external/jquery.contextMenu.css" rel="stylesheet">
    <!-- fullcalendar -->
    <link href="${cPath }/resources/fullCalendar/lib/main.css" rel="stylesheet">
    <!-- jsgantt -->
    <link href="${cPath }/resources/assets/dist/jsgantt.css" rel="stylesheet">
    <!-- jquery -->
    <script src="${cPath }/resources/js/external/jquery.min.js"></script>
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
	
