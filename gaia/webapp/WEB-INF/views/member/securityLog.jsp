<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 18, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container-fluid">
	<div class="row menu">
		<div class="col-lg-4 col-xl-3">
			<jsp:include page="side-bar.jsp"/>
		</div>
		<div class="col-lg-8 col-xl-9">
			<div class="row justify-content-end">
				<div class="col col-md-3">
					<ol class="breadcrumb">
					    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
					    <li class="breadcrumb-item active">
					    	<a class="moveButton" data-menu="${menuname}" 
					    			onclick = "toOverview()" href="javascript:void(0)">${menuname}</a>
					    </li>
					</ol>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
				    <div class="basic-list-group ">
			            <div class="toolbar" role="toolbar">
			            	<h2>Security Log</h2>
			            </div>
			            <hr>
					        <div class="card-body">
                    			<h5>Recent Log</h5>
							</div>
	                    <div id='logList'>
					    </div>
					</div>
		    	</div>
			</div>
		</div> <!-- col-lg-8 col-xl-9 END -->
	</div>
</div>
<div id="logTemplate" hidden="hidden">
	<div class="card log">
		<div class="card-body row log-card-body">
			<div class="col-md-2 log-img-center">
				<a class="profile_img_label" data-toggle="tooltip" data-placement="bottom" 
						title="Tooltip on bottom" data-id="" onclick="toOverview();" href="javascript:void();">
					<img class="rounded-circle profile_img" height="50" width="50" src="${mem_pic_file_name }">
		   		</a>
		   		<input type="hidden" value="" name="mem_id">
		   	</div>
	   	 	<div class="col-md-10">
		        <div class="log-card-actor">
	            	<a>KrGil - user.login</a>
	         	</div>
	         	<div class="log-card-action">
	         		Logged in
	         	</div>
	         	<div class="log-card-ip">
	         		192.168.0.1
	         		<span class="vertical-separator"></span>
	         		28 days ago
	         	</div>
	      	</div>
		</div>
	</div>
</div>
<script>
	loadMemberInfo_log();
</script>