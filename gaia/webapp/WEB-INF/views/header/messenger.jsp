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
	<span class="badge gradient-1 badge-pill badge-primary"></span>
</a>

<div class="drop-down dropdown-menu animated fadeIn position-fixed" style="position:fixed">
	<div class="dropdown-content-heading d-flex justify-content-between">
		<span class=""> 새로운 메시지가 없습니다.</span>
	</div>
	<div class="dropdown-content-body">
		<ul id="messageList">
			<!-- 템플릿들 들어가는 자리  -->
		</ul>
		<div class="dropdown-divider"></div>
		<a class="dropdown-item toChattingPage moveButton" data-menu="chat" href="javascript:void()">see more chats ...</a>
	</div>
</div>


<!--  템플릿  -->
<div >
	<ul id="messengerTemplate" hidden="hidden">
		<li class="messenger">
			<a>
				<img class="float-left mr-3 avatar-img" src="${cPath }/resources/assets/images/avatar/1.jpg" alt="">
				<div class="notification-content">
					<div class="notification-heading">Saiful Islam</div>
					<div class="notification-timestamp">08 Hours ago</div>
					<div class="notification-text">Hi Teddy, Just wanted to
						let you ...</div>
				</div>
			</a>
		</li>
	</ul>
</div>

<script>
// chattingPage로 이동.
$(".toChattingPage.moveButton").on('click',  function(){
	event.preventDefault();
	let menuName = $(this).data('menu');
	memberMovePageHistory(menuName);
})
// 페이지 로딩 시 데이터 받기.
var messengerData = function(){
}

</script>
