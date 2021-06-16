package best.gaia.chat.controller;
import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.alarm.controller.AlarmREST;
import best.gaia.alarm.dao.AlarmDao;
import best.gaia.alarm.service.AlarmService;
import best.gaia.chat.dao.OracleChatDao;
import best.gaia.chat.service.ChatService;
import best.gaia.vo.AlarmVO;
import best.gaia.vo.ChatRoomVO;

@RestController
@RequestMapping(value="restapi/chat/chats", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ChatREST {
	@Inject
	private ChatService service;
	@Inject
	private OracleChatDao dao;
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	 
	private static final Logger logger = LoggerFactory.getLogger(AlarmREST.class);
	
	@GetMapping
	public Map<String, Object> messageList(
			Authentication authentication
			, @RequestParam String need
			, @ModelAttribute("chatRoomVO") ChatRoomVO chatRoomVO
			) {
		// authentication에서 mem_no를 받아온다.
		Map<String, Object> result = new HashMap<String, Object>();
		List<ChatRoomVO> roomList = new ArrayList<>();
		int mem_no = getMemberNoFromAuthentication(authentication);
		// roomList의 room 번호마다 채팅들 담기
		if("chatRoomList".equals(need)) {
			// roomList 뽑기 
			roomList = service.selectMemberChatRoomList(mem_no);
			List<Map<String, Object>> lateChat = new ArrayList<Map<String, Object>>();
			for(ChatRoomVO chatRoom : roomList) {
				// chatRoomVO의 chatList에 대화 내용들 담기.
				int chatRoom_no = chatRoom.getChatroom_no();
				// elastic에서 chatList 뽑기.
				lateChat = service.getMessageListbyChatRoomOne(chatRoom_no, 1); 
				// 뽑은 chatList를 해당 room의 chatList에 담기.
				chatRoom.setChatList(lateChat);
			} 
			
		// 해당 방의 채팅내역 불러오기
		}else if("chatContent".equals(need)) {
			logger.info("chatRoomVO = {}\n\n\n\n\n", chatRoomVO.toString());
			// modelAttribute로 가지고 온 chatroom_no를 가지고 해당 방의 채팅 내역들 뽑은 후 chatList에 담기.
			chatRoomVO.setChatList(service.getMessageListbyChatRoom(chatRoomVO.getChatroom_no()));
			result.put("chatList", chatRoomVO);
		}
		logger.info("{}", roomList);
		result.put("roomList", roomList);
		return result;
	}
	 
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertMessage() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Integer updateAlarm(
			Authentication authentication
			) {
		// authentication에서 mem_no를 받아온다.
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		// 안 읽은 모든 알람을 현 시간에 읽은 것으로 업데이트 시키고, 업데이트 된 갯수를 반환한다.
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteAlarm() {
		return null;
	}
	
}







