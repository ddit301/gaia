package best.gaia.utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;

import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.MemberUserDetails;
import best.gaia.vo.MemberVO;

public class SessionUtil {
	
	@Resource(name="userList")
	static private List<WebSocketSession> userList;
	
	/**
	 *  Authentication 에서 mem_no 를 받아오는 메서드 입니다.
	 * @param authentication
	 * @return
	 */
	static public int getMemberNoFromAuthentication(Authentication authentication) {
		if(authentication == null) {
			throw new UnauthorizedException();
		}
		
		MemberVO member = ((MemberUserDetails) authentication.getPrincipal()).getAdaptee();
		if(member == null) {
			throw new UnauthorizedException();
		}
		
		return member.getMem_no();
	}
	
	/**
	 * Session 에서 현재 접속중인 프로젝트의 proj_no 를 받아오는 메서드 입니다.
	 * @param session
	 * @return
	 */
	static public Integer getProjNoFromSession(HttpSession session){
		Integer proj_no = (Integer)session.getAttribute("proj_no");
		if(proj_no == null) {
			throw new UnauthorizedException();
		}
		return proj_no;
	}
	
	/**
	 * WebSocketSession 에서 MemberVO를 꺼내오는 메서드 입니다.
	 * @param WebSocketSession 
	 * @return MemberVO
	 */
	static public MemberVO getMemberVoFromWebsocketSession(WebSocketSession session) {
		if(session == null)
			return null;
		
		Authentication authentication = (Authentication)session.getPrincipal();
		if(!(authentication.getPrincipal() instanceof MemberUserDetails))
			return null;
		
		MemberUserDetails userDetails= (MemberUserDetails)authentication.getPrincipal();
		return userDetails.getAdaptee();
		
	}
	
	/**
	 * WebSocketSession 에서 mem_no를 꺼내오는 메서드 입니다.
	 * @param WebSocketSession
	 * @return mem_no
	 * 비회원일 경우 0 이 반환됩니다.
	 */
	static public int getMemberNoFromWebsocketSession(WebSocketSession session) {
		MemberVO member = getMemberVoFromWebsocketSession(session);
		
		if(member == null)
			return 0;
		
		return member.getMem_no();
		
	}
	
	/**
	 * 특정 WebSocketSession 에 Map 형태의 data를 보내는 메서드 입니다.
	 * @param session
	 * @param dataType
	 * @param data
	 */
	static public void sendDataToWebsocketSession(
			WebSocketSession session
			,String dataType
			, Map<String,Object> data) {
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("dataType", dataType);
		returnData.put("data", data);
		
		String jsonData = new Gson().toJson(returnData);
		
		try {
			session.sendMessage(new TextMessage(jsonData));
		} catch (IOException e) {
		}
	}
	
	/**
	 *  특정 WebSocketSession 에 String 형태의 data를 보내는 메서드 입니다.
	 * @param session
	 * @param dataType
	 * @param data
	 */
	static public void sendDataToWebsocketSession(
			WebSocketSession session
			,String dataType
			, String data) {
		Map<String, String> returnData = new HashMap<String, String>();
		returnData.put("dataType", dataType);
		returnData.put("data", data);
		
		String jsonData = new Gson().toJson(returnData);
		
		try {
			session.sendMessage(new TextMessage(jsonData));
		} catch (IOException e) {
		}
	}
	
	
	
}
