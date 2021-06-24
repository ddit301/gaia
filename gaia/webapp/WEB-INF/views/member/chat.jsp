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
    <div class="row position-fixed">
        <div class="col-lg-4 col-xl-3 col-xl-3-custom">
            <div class="card chatRoomList-over side-position-fixed"> 
                <div class="card-body side-bar-card-body">
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
		<div class="col-lg-8 col-xl-9 col-xl-9-custom">
 			<div class="chat">
				<div class="row">
					<div class="col-md-9">
						<div class="chat-top row">
							<div class="col-md-3 log-img-center chat-img chat_img">
								<img class="rounded-circle profile_img img-center pro_img chat-top-img-size" onerror="imgOnErr()" height="50" width="50" src="">
								<img class="rounded-circle profile_img img-left pro_img chat-top-img-size" onerror="imgOnErr()" height="50" width="50" src="">
								<img class="rounded-circle profile_img img-right pro_img chat-top-img-size" onerror="imgOnErr()" height="50" width="50" src="">
							</div>
							<div class="col-md-6 membersId">
								<span></span>
							</div>
							<div class="col-md-3 ">
								<span></span>
							</div>
						</div>
						<div class="chat-mid chat-room border-top border-bottom" id="this-is-chatRoom" data-room_no="">
							<!-- chattings -->
						</div>
						<div class="chat-bot pt-1">
						<form class="row" action="javascript:void();">
							<div class="col-md-1">
							</div>
							<div class="col-md-9 inputForm">
								<textArea id="chatInput"></textArea>
							</div>
							<div class="col-md-2 inputChatText">
								<button onclick="inputChat();" type="submit" class="btn mb-1 btn-outline-dark">button</button>
							</div>
							</form>
						</div>
					</div>			            
					<div class="col-md-3 border-left" >
						<div class="chat-room-right">
							<div class="chat-room-position-above">
								<div class="log-img-center chat-img chat_img">
									<img onerror="imgOnErr()" class="rounded-circle profile_img img-center pro_img" height="100" width="100" src="">
									<img onerror="imgOnErr()" class="rounded-circle profile_img img-left pro_img chat-room-right" height="100" width="100" src="">
									<img onerror="imgOnErr()" class="rounded-circle profile_img img-right pro_img chat-room-right" height="100" width="100" src="">
								</div>
							</div>
							<div class="chat-room-position-under">
								<div class="membersId">
									<span>
										
									</span>
								</div>
							</div>
						</div>
					</div>			            
				</div>
		    </div>
		</div>
    </div>
</div>
<!-- chat  -->
<div id="chatTemplate" hidden="hidden">
	<div class="chat-box left">
		<div class="chat-card clear" >
			<div class="card-body"  >
				<div class="chat-mid-top" >
					<span>a</span>
				</div>
			</div>
		</div>
		<div class="chat-date" data-date="">
			<span>10:24</span>
		</div>
	</div>
	
	<div class="chat-day-alarm" style="clear:both;">
		<span></span>
		<hr>
	</div>
</div>
<!-- sidebar 채팅룸들 -->
<div id="side-barChatRoomTemplate" hidden="hidden">
	<li class="chatRoom" >
		<div class="card">
			<div class="row chatList-card-body">
				<div class="col-md-5 log-img-center chat-img pr-0">
					<img onerror="imgOnErr()" class="rounded-circle profile_img img-center pro_img" height="50" width="50" src="">
					<img onerror="imgOnErr()" class="rounded-circle profile_img img-left pro_img" height="50" width="50" src="">
					<img onerror="imgOnErr()" class="rounded-circle profile_img img-right pro_img" height="50" width="50" src="">
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
				<img class="profile" onerror="imgOnErr()">
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