package best.gaia.utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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
	 * Authentication 에서 memberVO를 꺼내오는 메서드 입니다.
	 * @param authentication
	 * @return
	 */
	static public MemberVO getMemberVoFromAuthentication(Authentication authentication) {
		if(authentication == null) {
			throw new UnauthorizedException();
		}
		MemberVO member = ((MemberUserDetails) authentication.getPrincipal()).getAdaptee();
		if(member == null) {
			throw new UnauthorizedException();
		}
		return member;
	}
	
	/**
	 *  Authentication 에서 mem_no 를 받아오는 메서드 입니다.
	 * @param authentication
	 * @return
	 */
	static public int getMemberNoFromAuthentication(Authentication authentication) {
		return getMemberVoFromAuthentication(authentication).getMem_no();
	}
	
	/**
	 *  Authentication 에서 mem_id 를 받아오는 메서드 입니다.
	 * @param authentication
	 * @return
	 */
	static public String getMemberIdFromAuthentication(Authentication authentication) {
		return getMemberVoFromAuthentication(authentication).getMem_id();
	}
	
	/**
	 * Session 에서 현재 접속중인 프로젝트의 proj_no 를 받아오는 메서드 입니다.
	 * @param session
	 * @return pro_jo
	 * @exception session이 없거나, 저장된 proj_no 가 없으면 401 에러를 발생
	 */
	static public Integer getProjNoFromSession(HttpSession session){
		if(session == null)
			throw new UnauthorizedException();
		
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
		if(session == null)
			return;
		
		Map<String, String> returnData = new HashMap<String, String>();
		returnData.put("dataType", dataType);
		returnData.put("data", data);
		
		String jsonData = new Gson().toJson(returnData);
		
		try {
			session.sendMessage(new TextMessage(jsonData));
		} catch (IOException e) {
		}
	}
	
	
	/**
	 * 특정 웹소켓 sessionList 에게 data를 보내는 메서드 입니다.
	 * @param sessionList
	 * @param dataType
	 * @param data
	 */
	static public void sendDataToWebsocketSessionList(
			List<WebSocketSession> sessionList
			,String dataType
			, String data) {
		if(sessionList == null || sessionList.size()==0)
			return;
		
		Map<String, String> returnData = new HashMap<String, String>();
		returnData.put("dataType", dataType);
		returnData.put("data", data);
		
		String jsonData = new Gson().toJson(returnData);
		
		for(WebSocketSession session : sessionList) {
			try {
				session.sendMessage(new TextMessage(jsonData));
			} catch (IOException e) {}
		}
		
	}
	
	// 파라미터를 바탕으로 히스토리 유형 찾아주는 메서드
	public static String getHistoryType(String editpart, Optional<String> parameter) {
		boolean isDelete = !parameter.isPresent();
		
		String type = null;
		
		switch(editpart) {
			case "milest_sid": type = isDelete ? "RM" : "EM"; break;
			case "assigneeAdd": type = "AA"; break;
			case "assigneeDel": type = "RA"; break;
			case "label_no": type = isDelete ? "RL" : "EL"; break;
			case "issue_priority": type = isDelete ? "RP" : "EP"; break;
			case "issue_start_date": type = "ES"; break;
			case "issue_end_date": type = "EE"; break;
			case "issue_title": type = "ET"; break;
			case "issue_status": 
				type = "0".equals(parameter.get())? "IO" : "IC";
				break;
		}
		
		return type;
	}
	
}
