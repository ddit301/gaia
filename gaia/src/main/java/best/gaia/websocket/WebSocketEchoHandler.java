package best.gaia.websocket;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import best.gaia.utils.components.WebSocketComponent;

public class WebSocketEchoHandler extends TextWebSocketHandler {
	
	@Resource(name="userList")
	private List<WebSocketSession> userList;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		userList.add(session);
		for(WebSocketSession user :userList) {
			user.sendMessage(new TextMessage("한명 추가로 들어왔음. 접속중인원 : " + userList.size()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userList.remove(session);
//		for(WebSocketSession user :userList) {
//			user.sendMessage(new TextMessage("한명 나갔음. 접속중인원 : " + userList.size()));
//		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String data = message.getPayload();
		for(WebSocketSession user :userList) {
			user.sendMessage(new TextMessage(data));
		}
	}
	
}
