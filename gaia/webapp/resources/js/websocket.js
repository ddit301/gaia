const server = "wss://"+location.host+getContextPath()+"/echo";
let socket = null; 

$(window).on('beforeunload', function(){
	socket.close();
});

$(function(){
	// 페이지 접속시 자동으로 웹소켓 연결을 수립합니다.
	socket = new WebSocket(server);
	
	// 웹소켓에 data가 도착했을 경우 이벤트를 처리합니다. 
	socket.onmessage = function(event){
		
		let pushData = JSON.parse(event.data);
		let dataType = pushData.dataType;
		let data = pushData.data;
		
		if(dataType == 'alarm'){
			// 새로운 알람이 도착했을 경우에는 알림을 보내주고 종 모양을 바꿔준다.
			getAlarm();
			toastr.success(data);
			
		}else if(dataType == 'login'){
			// 새로운 회원이 도착했을 경우에도 알림을 보내준다.
			toastr.info(data);			
		}
		 
	}
	
})	
	
