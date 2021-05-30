<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
				<h4>Gantt Chart</h4>
				조회중인 프로젝트 생성자 : ${manager_nick }<br/>
				조회중인 프로젝트 타이틀 : ${project_title }
            </div>
            <!-- #/ container -->
     
   	<link rel="stylesheet" type="text/css" href="${cPath }/resources/ganttapi/jquery-ui-1.8.4.css" />
	<link rel="stylesheet" type="text/css" href="${cPath }/resources/ganttapi/reset.css" />
	<link rel="stylesheet" type="text/css" href="${cPath }/resources/ganttapi/jquery.ganttView.css" />       
     <div class = "gantt-body">     
  	<div id="ganttChart"></div>
	<br/><br/>
	<div id="eventMessage"></div>
	</div>   
	
	<script type="text/javascript" src="${cPath }/resources/ganttapi/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="${cPath }/resources/ganttapi/date.js"></script>
	<script type="text/javascript" src="${cPath }/resources/ganttapi/jquery-ui-1.8.4.js"></script>
	<script type="text/javascript" src="${cPath }/resources/ganttapi/jquery.ganttView.js"></script>
	
		<script type="text/javascript">
		var ganttData = [
			{
				id: 1, name: "Feature 1", series: [
					{ name: "Planned", start: new Date(2010,00,01), end: new Date(2010,00,03) },
					{ name: "Actual", start: new Date(2010,00,02), end: new Date(2010,00,05), color: "#f0f0f0" }
				]
			}, 
			{
				id: 2, name: "Feature 2", series: [
					{ name: "Planned", start: new Date(2010,00,05), end: new Date(2010,00,20) },
					{ name: "Actual", start: new Date(2010,00,06), end: new Date(2010,00,17), color: "#f0f0f0" },
					{ name: "Projected", start: new Date(2010,00,06), end: new Date(2010,00,17), color: "#e0e0e0" }
				]
			}, 
			{
				id: 3, name: "Feature 3", series: [
					{ name: "Planned", start: new Date(2010,00,11), end: new Date(2010,01,03) },
					{ name: "Actual", start: new Date(2010,00,15), end: new Date(2010,01,03), color: "#f0f0f0" }
				]
			}, 
			{
				id: 4, name: "Feature 4", series: [
					{ name: "Planned", start: new Date(2010,01,01), end: new Date(2010,01,03) },
					{ name: "Actual", start: new Date(2010,01,01), end: new Date(2010,01,05), color: "#f0f0f0" }
				]
			},
			{
				id: 5, name: "Feature 5", series: [
					{ name: "Planned", start: new Date(2010,02,01), end: new Date(2010,03,20) },
					{ name: "Actual", start: new Date(2010,02,01), end: new Date(2010,03,26), color: "#f0f0f0" }
				]
			}, 
			{
				id: 6, name: "Feature 6", series: [
					{ name: "Planned", start: new Date(2010,00,05), end: new Date(2010,00,20) },
					{ name: "Actual", start: new Date(2010,00,06), end: new Date(2010,00,17), color: "#f0f0f0" },
					{ name: "Projected", start: new Date(2010,00,06), end: new Date(2010,00,20), color: "#e0e0e0" }
				]
			}, 
			{
				id: 7, name: "Feature 7", series: [
					{ name: "Planned", start: new Date(2010,00,11), end: new Date(2010,01,03) }
				]
			}, 
			{
				id: 8, name: "Feature 8", series: [
					{ name: "Planned", start: new Date(2010,01,01), end: new Date(2010,01,03) },
					{ name: "Actual", start: new Date(2010,01,01), end: new Date(2010,01,05), color: "#f0f0f0" }
				]
			}
		];
		
		$(function () {
			$("#ganttChart").ganttView({ 
				data: ganttData,
				slideWidth: 900,
				behavior: {
					onClick: function (data) { 
						var msg = "You clicked on an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
						$("#eventMessage").text(msg);
					},
					onResize: function (data) { 
						var msg = "You resized an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
						$("#eventMessage").text(msg);
					},
					onDrag: function (data) { 
						var msg = "You dragged an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
						$("#eventMessage").text(msg);
					}
				}
			});
	
			// $("#ganttChart").ganttView("setSlideWidth", 600);
		});
	</script>
