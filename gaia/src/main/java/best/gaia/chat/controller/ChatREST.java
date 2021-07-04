package best.gaia.chat.controller;
import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;
import static best.gaia.utils.SessionUtil.getMemberVoFromAuthentication;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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
import best.gaia.utils.enumpkg.ServiceResult;
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
	
	/**
	 *	GET
	 */
	@GetMapping(params = {"need=chatContent"})
	public Map<String, Object> chatContent(
				Authentication authentication
				, @RequestParam String need
				, @ModelAttribute("chatRoomVO") ChatRoomVO chatRoomVO
			) {
		MemberVO member = getMemberVoFromAuthentication(authentication);
		// modelAttribute로 가지고 온 chatroom_no를 가지고 해당 방의 채팅 내역들 뽑은 후 chatList에 담기.
		chatRoomVO.setChatList(service.getMessageListbyChatRoom(chatRoomVO.getChatroom_no()));
		
		// 해당 방의 memberList 가지고 오기
		List<MemberVO> memberList = service.memberListByChatRoom(chatRoomVO.getChatroom_no());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("chatRoom", chatRoomVO);
		result.put("mem_id", member.getMem_id());
		result.put("memberList", memberList);
		return result;
	}
	
	@GetMapping(params = {"need=chatRoomList"})
	public Map<String, Object> chatRoomList(
				Authentication authentication
				, @RequestParam String need
			) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		MemberVO member = getMemberVoFromAuthentication(authentication);
		// roomList의 room 번호마다 채팅들 담기
		List<ChatRoomVO> roomList = service.selectMemberChatRoomList(mem_no);
		List<Map<String, Object>> lateChat = new ArrayList<Map<String, Object>>();
		
		for(ChatRoomVO chatRoom : roomList) {
			// chatRoomVO의 chatList에 대화 내용들 담기.
			int chatRoom_no = chatRoom.getChatroom_no();
			// elastic에서 chatList 뽑기.
			lateChat = service.getMessageListbyChatRoomOne(chatRoom_no, 1); 
			// 뽑은 chatList를 해당 room의 chatList에 담기.
			chatRoom.setChatList(lateChat);
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("roomList", roomList);
		result.put("mem_id", member.getMem_id());
		return result;
	}
	
	@GetMapping(params = {"need=searchMemberList"})
	public Map<String, Object> searchMemberList(
				Authentication authentication
				, @RequestParam String need
				, @RequestParam(required=false) String keyword
			) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		Map<String, Object> searchInfo = new HashMap<>();
		searchInfo.put("mem_no",mem_no);
		searchInfo.put("keyword",keyword);
		
		List<MemberVO> memberList = service.searchMemberList(searchInfo);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("memberList", memberList);
		return result;
	}
	
	/**
	 *	POST 
	 */
	@PostMapping
	public Map<String, Object> insertMessage(
				Authentication authentication
				, @RequestParam String need
				, @ModelAttribute("chatRoomVO") ChatRoomVO chatRoomVO
			) {
		MemberVO member = getMemberVoFromAuthentication(authentication);
		return null;
	}
	
	@PostMapping(params = {"need=elastic"})
	public Map<String, Object> insertMessageToElastic(
				Authentication authentication
				, @RequestParam String need
				, @RequestParam Map<String, Object> chat
			) {
		MemberVO member = getMemberVoFromAuthentication(authentication);
		
		chat.remove("need");
		ServiceResult res = service.insertElasticMessage(member.getMem_no(), chat);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", res);
		return result;
	}
	
	@PostMapping(params = {"need=oracle"})
	public Map<String, Object> insertChatRoom(
				Authentication authentication
				, @RequestParam String need
				, @ModelAttribute("roomInfo") ChatRoomVO roomInfo
				, @RequestParam Map<String, Object> mem_nos
			) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		MemberVO member = getMemberVoFromAuthentication(authentication);
		List<Map<String, Object>> currentChat = null;
		mem_nos.remove("need");
		mem_nos.put("mem_no1", member.getMem_no());
		logger.info("mem_nos {}", mem_nos);
		// 채팅방이 존재하는지 확인
		int exists = service.exists(mem_nos);
		// 채팅방이 존재하지 않는다면 
		if(exists==0) {
			// 새로운 채팅방 추가.
			ServiceResult result = service.createChatRoom(roomInfo, mem_nos);
			// 채팅방 생성여부 확인 후 잘 생성되었다면 채팅방 번호 넘기기  
			exists = !ServiceResult.OK.equals(result) ? 0 : roomInfo.getChatroom_no();
			// roomList에 채팅 내역 elastic에서 가지고와서 담기.(정렬시키기.)
			try {
				Thread.sleep(500);
				currentChat = service.getMessageListbyChatRoomOne(roomInfo.getChatroom_no(), 1);
			} catch (InterruptedException e) { e.printStackTrace(); }
			roomInfo.setChatList(currentChat);
		}
		
		// roomList의 room 번호마다 채팅들 담기
		List<ChatRoomVO> roomList = service.selectMemberChatRoomList(mem_no);
		List<Map<String, Object>> lateChat = new ArrayList<Map<String, Object>>();
		
		for(ChatRoomVO chatRoom : roomList) {
			// chatRoomVO의 chatList에 대화 내용들 담기.
			int chatRoom_no = chatRoom.getChatroom_no();
			// 만약 elastic에서 데이터를 못 받아온다면 직접 날짜값 집어넣기.
			if(chatRoom_no == roomInfo.getChatroom_no()){
				// elastic에서 chatList 뽑기. 해당 번호라면 좀 더 기다렸다가 데이터 요청하기.
				try {
					Thread.sleep(500);
					lateChat = service.getMessageListbyChatRoomOne(chatRoom_no, 1);
				} catch (InterruptedException e) { e.printStackTrace(); }
			}else {
				lateChat = service.getMessageListbyChatRoomOne(chatRoom_no, 1);
			}
			
			// 뽑은 chatList를 해당 room의 chatList에 담기.
			chatRoom.setChatList(lateChat);
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("roomList", roomList);
		result.put("mem_id", member.getMem_id());
		result.put("result", exists);
		return result;
	}
}







