package best.gaia.chat.controller;
import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;
import static best.gaia.utils.SessionUtil.getMemberVoFromAuthentication;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.alarm.controller.AlarmREST;
import best.gaia.chat.dao.OracleChatDao;
import best.gaia.chat.service.ChatService;
import best.gaia.vo.ChatRoomVO;
import best.gaia.vo.MemberVO;

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
			, @RequestParam(required=false) String keyword
			) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		Map<String, Object> result = new HashMap<String, Object>();
		List<ChatRoomVO> roomList = new ArrayList<>();
		
		logger.info("need : {}", need);
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
			// modelAttribute로 가지고 온 chatroom_no를 가지고 해당 방의 채팅 내역들 뽑은 후 chatList에 담기.
			chatRoomVO.setChatList(service.getMessageListbyChatRoom(chatRoomVO.getChatroom_no()));
			result.put("chatRoom", chatRoomVO); 
		}else if("searchMemberList".equals(need)) {
			Map<String, Object> searchInfo = new HashMap<>();
			searchInfo.put("mem_no",mem_no);
			searchInfo.put("keyword",keyword);
			
				List<MemberVO> memberList = service.searchMemberList(searchInfo);
			result.put("memberList", memberList);
		}
		logger.info("{}", roomList);
		result.put("roomList", roomList);
		return result;
	}
	 
	@PostMapping
	public Map<String, Object> insertMessage(
			Authentication authentication
			, @RequestParam String need
			, @ModelAttribute("chatRoomVO") ChatRoomVO chatRoomVO
			) {
		MemberVO member = getMemberVoFromAuthentication(authentication);
		member.getMem_id();
		member.getMem_no();
		
		return null;
	}
	@PostMapping(params = {"need=elastic"})
	public Map<String, Object> insertMessageToElastic(
			Authentication authentication
			, @RequestParam String need
			, @RequestParam Map<String, Object> chat
			) {
		MemberVO member = getMemberVoFromAuthentication(authentication);
		member.getMem_id();
		member.getMem_no();
		chat.remove("need");
		logger.info("chat : {}\n\n\n", chat);
		service.insertElasticMessage(member.getMem_no(), chat);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", "OK");
		return result;
	}
}







