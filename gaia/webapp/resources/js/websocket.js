const server = (location.protocol == "https:" ? "wss" : "ws" ) + "://"+location.host+getContextPath()+"/echo";

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
			
			// 일단 json parsing이 가능한지 체크한다.
			if(IsJsonString(data)){
				
				let jsonData = JSON.parse(data);
				let type = jsonData.type;
				
				// 프로젝트 초대 관련 알람일 경우
				if(type == 'PJ'){
					let proj_title = jsonData.project_title;
					let manager_id = jsonData.manager_id;
					
					// 좌측의 프로젝트 목록에 추가시켜 줍니다.
					let projBox = $('#preloaderTemplate').children('.projBox').clone();
					let initial = proj_title.substring(0,1).toUpperCase();
					let projBtn = projBox.children('button');
					projBtn.text(initial);
					let tooltipText = proj_title;
					projBtn.attr('title', tooltipText);
					projBtn.attr('data-manager_id', manager_id);
					projBtn.attr('data-project_title', proj_title);
					
					let projBoxes = $('.proj_boxes'); 
					projBoxes.append(projBox);
					
					// 동적으로 추가한 요소에 툴팁 활성화 시켜준다.
					projBoxes.tooltip({
				   	 selector: '.square__box'
					});
					
					// sweet alert로 초대 받았다고 알립니다.
					Swal.fire({
					  icon: 'success',
					  title: proj_title +'프로젝트에 <br> 초대되었습니다.',
					  showConfirmButton: false,
					  timer: 2500
					})
				}
				
				
			}else{
				// 새로운 알람이 도착 했는데, json parsing이 불가능 할 경우 data가 이미 알람 메시지로 정해져서 온 겁니다.
				toastr.success(data);
			}
			
		}else if(dataType == 'login'){
			// 새로운 회원이 도착했을 경우에도 알림을 보내준다.
			toastr.info(data);			
		}
		 
	}
	
})	
	
