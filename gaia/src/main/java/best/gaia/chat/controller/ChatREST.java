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
		// modelAttribute??? ????????? ??? chatroom_no??? ????????? ?????? ?????? ?????? ????????? ?????? ??? chatList??? ??????.
		chatRoomVO.setChatList(service.getMessageListbyChatRoom(chatRoomVO.getChatroom_no()));
		
		// ?????? ?????? memberList ????????? ??????
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
		// roomList??? room ???????????? ????????? ??????
		List<ChatRoomVO> roomList = service.selectMemberChatRoomList(mem_no);
		List<Map<String, Object>> lateChat = new ArrayList<Map<String, Object>>();
		
		for(ChatRoomVO chatRoom : roomList) {
			// chatRoomVO??? chatList??? ?????? ????????? ??????.
			int chatRoom_no = chatRoom.getChatroom_no();
			// elastic?????? chatList ??????.
			lateChat = service.getMessageListbyChatRoomOne(chatRoom_no, 1); 
			// ?????? chatList??? ?????? room??? chatList??? ??????.
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
		// ???????????? ??????????????? ??????
		int exists = service.exists(mem_nos);
		// ???????????? ???????????? ???????????? 
		if(exists==0) {
			// ????????? ????????? ??????.
			ServiceResult result = service.createChatRoom(roomInfo, mem_nos);
			// ????????? ???????????? ?????? ??? ??? ?????????????????? ????????? ?????? ?????????  
			exists = !ServiceResult.OK.equals(result) ? 0 : roomInfo.getChatroom_no();
			// roomList??? ?????? ?????? elastic?????? ??????????????? ??????.(???????????????.)
			try {
				Thread.sleep(500);
				currentChat = service.getMessageListbyChatRoomOne(roomInfo.getChatroom_no(), 1);
			} catch (InterruptedException e) { e.printStackTrace(); }
			roomInfo.setChatList(currentChat);
		}
		
		// roomList??? room ???????????? ????????? ??????
		List<ChatRoomVO> roomList = service.selectMemberChatRoomList(mem_no);
		List<Map<String, Object>> lateChat = new ArrayList<Map<String, Object>>();
		
		for(ChatRoomVO chatRoom : roomList) {
			// chatRoomVO??? chatList??? ?????? ????????? ??????.
			int chatRoom_no = chatRoom.getChatroom_no();
			// ?????? elastic?????? ???????????? ??? ??????????????? ?????? ????????? ????????????.
			if(chatRoom_no == roomInfo.getChatroom_no()){
				// elastic?????? chatList ??????. ?????? ???????????? ??? ??? ??????????????? ????????? ????????????.
				try {
					Thread.sleep(500);
					lateChat = service.getMessageListbyChatRoomOne(chatRoom_no, 1);
				} catch (InterruptedException e) { e.printStackTrace(); }
			}else {
				lateChat = service.getMessageListbyChatRoomOne(chatRoom_no, 1);
			}
			
			// ?????? chatList??? ?????? room??? chatList??? ??????.
			chatRoom.setChatList(lateChat);
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("roomList", roomList);
		result.put("mem_id", member.getMem_id());
		result.put("result", exists);
		return result;
	}
}







