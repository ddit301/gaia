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
                <div class="card-body">
                	<div id="chatRoomList-top border-bottom" >
                		<h3 style="display:inline-block;">Chatting</h3>
                		<div class="right">
			                <span class="material-icons newVideoChat clickable">video_call</span>
			                <span class="material-icons newChat clickable">add_circle</span>
		                </div>
                	</div>
                   	<ul id="chatRoomList">
                   	</ul>
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
					<div class="col-md-8 ">
						<div class="chat-top row">
							<div class="col-md-3">aa</div>
							<div class="col-md-6">bvb</div>
							<div class="col-md-3">xcc</div>
						</div>
						<div class="chat-mid chat-room" id="this-is-chatRoom">
							<!-- chattings -->
						</div>
						<div class="chat-bot pt-1">
							<input type="text" name="mem_nick" class="form-control input-default" placeholder="Input Default">
						</div>
					</div>			            
					<div class="col-md-4 border-left" ></div>			            
				</div>
		    </div>
		</div>
    </div>
</div>
<!-- chat  -->
<div id="chatTemplate" hidden="hidden">
	<div class="chat-box">
	<div class="chat-card left clear" >
		<div class="chat-date">
			<span>10:24</span>
		</div>
		<div class="card-body" >
			<div class="chat-mid-top" >
				<span>a</span>
			</div>
		</div>
		<div style="clear:both;">
		</div>
	</div>
	</div>
	
	<div class="chat-day-alarm" style="clear:both;">
		<span></span>
	</div>
</div>
<!-- sidebar 채팅룸들 -->
<div id="chatRoomTemplate" hidden="hidden">
	<li class="chatRoom" >
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
	</li>
</div>

<!-- 회원 초대 Modal -->
<div class="modal fade" id="inviteMemberChat" tabindex="-1" aria-labelledby="inviteMemberLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="inviteMemberLabel">프로젝트 멤버 초대</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="inviteModal modal-body">
      	<input type="text"><button id="memSearchBtnChat" class="btn">검색</button>
    	<ul id="memSearchResultChat">
    	</ul> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div hidden="hidden">
<div id="setting-member-template-chat">
	<ul>
		<li class="searchedMemberChat">
			<img class="profile" src="/resources/images/profiles/1">
			<span class="memid">id</span>
			<span class="memnm">name</span>
			<span class="memnick">nick</span>
			<span class="memcity">city</span>
			<i class="icon-plus"></i>
		</li>
	</ul>
</div>
</div>
<script>
loadMemberInfo_chat();
</script>