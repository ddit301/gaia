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
import best.gaia.vo.ChatRoomVO;
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
	WebApplicationContext container;
	
//
//	@Test
//	public void testInsert() {
//		Map<String, Object> message = new HashMap<>();
//		message.put("chatroom_no", 3);
//		message.put("content", "thisaaa room3! nice to meet you!");
//		int result = chatDao.insertMessage(1, message);
//		System.out.println(result);
//	}
	@Test
	public void testSelect() {
		int chatRoom_no = 1;
		int size = 1;
		List<Map<String, Object>> result = chatDao.getMessageListbyChatRoomOne(chatRoom_no, size);
		System.out.println(result);
	}
//	
//	@Test
//	public void testChatRoomMessages() {
//		// 나의 채팅방들 중 한 방의 채팅들 불러오기
//		// 내가 속한 채팅방 목록 모두 불러오기.
//		List<ChatVO> roomList = orDao.selectMemberChatRoomList(1);
//		ChatVO chatvo = roomList.get(0);
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
