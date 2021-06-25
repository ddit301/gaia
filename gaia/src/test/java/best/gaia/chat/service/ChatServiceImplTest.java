package best.gaia.chat.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.chat.dao.ElasticChatDao;
import best.gaia.chat.dao.OracleChatDao;
import best.gaia.member.controller.MemberREST;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ChatRoomVO;
import best.gaia.vo.MemberVO;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class ChatServiceImplTest {
	private static final Logger logger = LoggerFactory.getLogger(ChatServiceImplTest.class);
	@Inject
	ElasticChatDao chatDao;
	@Inject
	OracleChatDao orDao;
	
	@Inject
	ChatService service;
	
	ChatRoomVO chatRoomVO = new ChatRoomVO();
	
	@Inject
	WebApplicationContext container;
	
	
	
	// 통합 검색 
	@Test
	public void testTotalSearch() {
		String keyword = "SMITH";
		
		
		List<Map<String, Object>> result = chatDao.getTotalSearchResult(keyword);
		System.out.println(result);
	}
	
	
	
	
	
//	@Test
	public void testCreateChatRoom() {
		ChatRoomVO roomInfo = new ChatRoomVO();
		Map<String, Object> mem_nos = new HashMap<String, Object>();
		mem_nos.put("mem_no1", 1);
		mem_nos.put("mem_no2", 3);
		ServiceResult result = service.createChatRoom(roomInfo, mem_nos);
		System.out.println(result);
	}
	
//	@Test
	public void testInsertChatRoom() {
		ChatRoomVO roomInfo = new ChatRoomVO();
		int result = orDao.insertChatRoom(roomInfo);
		System.out.println(roomInfo.getChatroom_no());
	}
//	@Test
	public void testDaoExist() {
		Map<String, Object> chat = new HashMap<>();
		
		chat.put("mem_no1", 1);
		chat.put("mem_no2", 3);
		int exists = service.exists(chat);
		System.out.println(exists);
		
		Map<String, Object> mem_nos = new HashMap<String, Object>();
		mem_nos.put("mem_no1", 1);
		mem_nos.put("mem_no2", 3);
		ChatRoomVO roomInfo = new ChatRoomVO();
		
		if(exists==0) {
			System.out.println("들어오면 안되는데 들어가진다 자뀨ㅜ ");
			ServiceResult result = service.createChatRoom(roomInfo, mem_nos);
			if(ServiceResult.OK != result) exists=0;
		}
		System.out.println("피했나??");
	}
//	@Test
	public void testInsert() {
		Map<String, Object> chat = new HashMap<>();
		
		chat.put("chatroom_no", 25);
		chat.put("content", "hi hello nihao thisaaa room1! nice to meet you!");
		ServiceResult result = service.insertElasticMessage(1, chat);
		System.out.println(result);
	}
//	@Test
	public void testSelect() {
		//방들의 최근 채팅 내역만 가지고 오기.
		int chatRoom_no = 1;
		int size = 1;
		List<Map<String, Object>> result = chatDao.getMessageListbyChatRoomOne(chatRoom_no, size);
		System.out.println(result);
	}
//	@Test
	public void testSelectChatListbyChatRoomNo() {
		// 해당 방의 채팅 내역들모두 가지고 오기
		int chatRoom_no = 1;
		int size = 1;
		chatRoomVO.setChatroom_no(chatRoom_no);
		chatRoomVO.setChatList(service.getMessageListbyChatRoom(chatRoomVO.getChatroom_no())); 
		System.out.println(chatRoomVO.toString());
	}
//	public void testChatRoomMessages() {
//		// 나의 채팅방들 중 한 방의 채팅들 불러오기
//		// 내가 속한 채팅방 목록 모두 불러오기.
//		List<ChatRoomVO> roomList = orDao.selectMemberChatRoomList(1);
//		ChatRoomVO chatvo = roomList.get(0);
//		int chatRoomNo = chatvo.getChatroom_no();
//		System.out.println(chatRoomNo);
//		
//		// 해당 방의 모든 채팅 들고오기.
//		List<Map<String, Object>> chatList = new ArrayList<Map<String, Object>>();
//		chatList = chatDao.getMessageListbyChatRoom(chatRoomNo);
//		System.out.println(chatList);
//		
//	}
	
}
