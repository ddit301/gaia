package best.gaia.utils.components;

import static best.gaia.utils.SessionUtil.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

@Component
public class WebSocketComponent {
	
	@Resource(name="userList")
	private List<WebSocketSession> userList;
	
	public List<WebSocketSession> getWebSocketSessionFromMemNo(int mem_no) {
		if(userList == null)
			return null;
		
		List<WebSocketSession> list = new ArrayList<>();
		
		for(WebSocketSession session : userList) {
			if(mem_no == getMemberNoFromWebsocketSession(session)) {
				list.add(session);
			}
		}
		return list;
	}
	
	public void sendPushNotificationToMember(
			int mem_no
			, String alarm_type
			, String data) {
		
		List<WebSocketSession> sessionlist = getWebSocketSessionFromMemNo(mem_no);
		if(sessionlist == null || sessionlist.size()==0 )
			return;
		
		String message = null;
		
		// 알람 타입별 메시지지만, 나중에는 공통 코드로 DB화 해서 하드코딩 하지 않도록 변경 해야 합니다.
		switch(alarm_type) {
		case "IC" : 
			message = data + "님이 당신의 이슈에 댓글을 달았습니다.";
			break;
		case "PJ" :
			message = data;
			break;
		}
		
		String dataType = "alarm";
		
		// 해당 세션으로 푸쉬 알림을 전송한다.
		sendDataToWebsocketSessionList(sessionlist, dataType, message);
		
		
	}

}
