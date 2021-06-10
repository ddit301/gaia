package best.gaia.utils.components;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;
import static best.gaia.utils.SessionUtil.*;

@Component
public class WebSocketComponent {
	
	@Resource(name="userList")
	private List<WebSocketSession> userList;
	
	public WebSocketSession getWebSocketSessionFromMemNo(int mem_no) {
		if(userList == null)
			return null;
		
		for(WebSocketSession session : userList) {
			if(mem_no == getMemberNoFromWebsocketSession(session)) {
				return session;
			}
		}
		return null;
	}
	
	public void sendPushNotificationToMember(
			int mem_no
			, String alarm_type
			, String sender) {
		
		WebSocketSession session = getWebSocketSessionFromMemNo(mem_no);
		if(session == null)
			return;
		
		String message = null;
		
		// 알람 타입별 메시지지만, 나중에는 공통 코드로 DB화 해서 하드코딩 하지 않도록 변경 해야 합니다.
		switch(alarm_type) {
		case "IC" : 
			message = sender + "님이 당신의 이슈에 댓글을 달았습니다.";
		}
		
		String dataType = "alarm";
		
		// 해당 세션으로 푸쉬 알림을 전송한다.
		sendDataToWebsocketSession(session, dataType, message);
		
		
	}

}
