// 알람 받아오는 함수
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










