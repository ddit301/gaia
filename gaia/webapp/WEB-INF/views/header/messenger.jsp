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
		<ul id="messageList">
		</ul>
		<div class="dropdown-divider"></div>
		<a class="dropdown-item toChattingPage moveButton" data-menu="chat" href="javascript:void()">see more chats ...</a>
	</div>
</div>
<!-- 템플릿들 들어가는 자리  -->

<!-- 	알람 템플릿 시작 -->
<li class="messenger " hidden="hidden">
	<a>
		<span class="mr-3 avatar-icon bg-success-lighten-1">
			<i class="icon-bubbles"></i>
		</span>
		<div class="notification-content">
			<div class="notifi-cont notification-heading"></div>
			<span class="notifi-time notification-text"></span>
		</div>
	</a>
</li>
<!-- 	알람 템플릿 끝 -->
<li class="messenger" hidden="hidden">
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
//알람 받아오는 함수
var getAlarm = function(){
	$.ajax({
		url : getContextPath() + '/restapi/alarm/alarms',
		success : function(res) {
			let newAlarmCount = 0;
			$('#alarmList').empty();
			$.each(res, function(i, v) {
				let alarm = $('#headerTemplate').children('.alarm').clone();
				alarm.children('a').attr('href',v.url);
				alarm.find('.notifi-cont').html(v.alarm_cont);
				alarm.find('.notifi-time').text(moment(v.alarm_create_date).fromNow());
				if(v.alarm_chk_date == null){
					newAlarmCount = newAlarmCount +1;
					alarm.addClass("unchecked");
				}
				$('#alarmList').append(alarm);
			})
			// 새로운 알람이 있는지 없는지에 따라 분기
			if(newAlarmCount == 0){
				$('#alarmHeader').text('새로운 알람이 없습니다');
				$('.newAlarmCount').prop('hidden',true);
			}else{
				$('#alarmHeader').text(newAlarmCount + ' 개의 새로운 알람이 있습니다.');
				$('.newAlarmCount').prop('hidden',false);
			}
			$('.newAlarmCount').text(newAlarmCount);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
	})
}

/****************************************************************** 
*
*	document 준비 되었을때 버튼들 바인딩
*
*
 *******************************************************************/
$(function(){
	// 알람 확인시 알람을 확인했다는 신호를 보내서 모든 미확인 알람들의 ALARM_CHK_DATE를 현 시간으로 수정해줍니다.
	$('#alarmIcon').on('click', function(){
		
//		 새로운 알람 갯수가 0이 아닐 경우 새로운 알람을 읽음으로 업데이트 한다.
		if($('.newAlarmCount').text() > 0){
			$.ajax({
				url : getContextPath() + '/restapi/alarm/alarms',
				method : 'put',
				success : function(res) {
					checkedAlarm = res;
					$('.newAlarmCount').text('0');
					$('.newAlarmCount').prop('hidden',true);
				},
				error : function(xhr, error, msg) {
					ajaxError(xhr, error, msg);
				},
				dataType : 'json'
			})
		}else{
			// 새로운 알람의 갯수가 0 일 경우에는 새로운 알람이 없다고 바꾸며 모든 unchecked 클래스 체크를 없앤다.
			$('#alarmHeader').text('새로운 알람이 없습니다');
			$('.unchecked').removeClass('unchecked');
		}
	})
})
</script>
