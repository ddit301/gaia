<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* Jun 8, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<a href="javascript:void(0)" data-toggle="dropdown"> 
	<i class="mdi mdi-email-outline"></i> 
	<span class="badge gradient-1 badge-pill badge-primary">3</span>
</a>

<div class="drop-down dropdown-menu animated fadeIn position-fixed" style="position:fixed">
	<div class="dropdown-content-heading d-flex justify-content-between">
		<span class="">3 New Messages</span>
	</div>
	<div class="dropdown-content-body">
		<ul>
			<li class="notification-unread">
				<a href="javascript:void()">
					<img class="float-left mr-3 avatar-img" src="${cPath }/resources/assets/images/avatar/1.jpg" alt="">
					<div class="notification-content">
						<div class="notification-heading">Saiful Islam</div>
						<div class="notification-timestamp">08 Hours ago</div>
						<div class="notification-text">Hi Teddy, Just wanted to
							let you ...</div>
					</div>
				</a>
			</li>
			<li class="notification-unread">
				<a href="javascript:void()">
					<img class="float-left mr-3 avatar-img" src="${cPath }/resources/assets/images/avatar/2.jpg" alt="">
					<div class="notification-content">
						<div class="notification-heading">Adam Smith</div>
						<div class="notification-timestamp">08 Hours ago</div>
						<div class="notification-text">Can you do me a favour?</div>
					</div>
				</a>
			</li>
			<li>
				<a href="javascript:void()"> <img class="float-left mr-3 avatar-img" src="${cPath }/resources/assets/images/avatar/3.jpg" alt="">
					<div class="notification-content">
						<div class="notification-heading">Barak Obama</div>
						<div class="notification-timestamp">08 Hours ago</div>
						<div class="notification-text">Hi Teddy, Just wanted to
							let you ...</div>
					</div>
				</a>
			</li>
			<li>
				<a href="javascript:void()"> <img class="float-left mr-3 avatar-img" src="${cPath }/resources/assets/images/avatar/4.jpg" alt="">
					<div class="notification-content">
						<div class="notification-heading">Hilari Clinton</div>
						<div class="notification-timestamp">08 Hours ago</div>
						<div class="notification-text">Hello</div>
					</div>
				</a>
			</li>
			<li>
			<div class="dropdown-divider"></div>
			<a class="dropdown-item toChattingPage moveButton" data-menu="chat" href="javascript:void()">see more chats ...</a>
		</li>
		</ul>
	</div>
</div>

<script>
// chattingPage로 이동.
$(".toChattingPage.moveButton").on('click',  function(){
	event.preventDefault();
	let menuName = $(this).data('menu');
	movePageHistoryMember(menuName);
})
// 페이지 로딩 시 데이터 받기.
var messengerData = function(){
}
</script>
