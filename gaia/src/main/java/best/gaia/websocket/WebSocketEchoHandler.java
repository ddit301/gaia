package best.gaia.websocket;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import best.gaia.utils.SessionUtil;
import best.gaia.vo.MemberVO;

public class WebSocketEchoHandler extends TextWebSocketHandler {
	
	@Resource(name="userList")
	private List<WebSocketSession> userList;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		userList.add(session);
		Map<String, String> data = new HashMap<>();
		data.put("dataType", "login");
		MemberVO member = SessionUtil.getMemberVoFromWebsocketSession(session);
		data.put("data", member.getMem_nick() + "님이 로그인 했습니다.<br/>현재 총 " + userList.size() + "명 접속중.");
		String jsonData = new Gson().toJson(data);
		
		for(WebSocketSession user :userList) {
			user.sendMessage(new TextMessage(jsonData));
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
