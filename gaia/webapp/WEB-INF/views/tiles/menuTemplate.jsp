<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
	<tiles:insertAttribute name="preScript" />
</head>
<body>
	<tiles:insertAttribute name="preloader" />
    <div id="main-wrapper">
    	<tiles:insertAttribute name="header" />
   	
    	<tiles:insertAttribute name="sidebar" />
		<div class="content-body">
		</div>
        <tiles:insertAttribute name="footer" />
    </div>
    <tiles:insertAttribute name="postScript" />
</body>
</html>
