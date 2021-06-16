<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* Jun 8, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4 col-xl-3">
            <div class="card chatRoomList-over side-position-fixed"> 
                <div class="card-body" id="chatRoomList">
                   	
                </div>
            </div>  
        </div>
		<div class="col-lg-8 col-xl-9">
			<div class="row justify-content-end">
				<div class="col col-md-3">
					<ol class="breadcrumb">
					    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
					    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
					</ol>
				</div>
			</div>
 			<div class="chat">
				<div class="row">
					<div class="col-md-8"></div>			            
					<div class="col-md-4 border-left" ></div>			            
				</div>
		    </div>
		</div>
    </div>
</div>

<div id="chatRoomTemplate" hidden="hidden">
	<ul class="chatRoom">
		<div class="card">
			<div class="row chatList-card-body">
				<div class="col-md-5 log-img-center chat-img">
					<img class="rounded-circle profile_img img-center pro_img" height="50" width="50" src="">
					<img class="rounded-circle profile_img img-left pro_img" height="50" width="50" src="">
					<img class="rounded-circle profile_img img-right pro_img" height="50" width="50" src="">
			   	</div>
		   	 	<div class="col-md-7 pr-0">
			        <div class="log-card-actor">
		            	<a class="font-bold-black">KrGil</a>
		         	</div>
		         	<div class="content side-bar-content">
		         		<span>hello!! my name...</span>
		         	</div>
		         	<div class="time">
		         		<span>28 days ago</span>
		         	</div>
		      	</div>
		   	</div>
		</div>
	</ul>
</div>
<script>
loadMemberInfo_chat();
</script>