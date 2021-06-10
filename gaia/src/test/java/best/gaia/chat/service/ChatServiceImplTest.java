package best.gaia.chat.service;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.chat.dao.OracleChatDao;
import best.gaia.member.dao.LogDao;
import best.gaia.member.dao.MemberDao;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class ChatServiceImplTest {

	@Inject
	OracleChatDao chatDao;
	
	@Inject
	WebApplicationContext container;
	
	@Test
	public void test() {
		Map<String, Object> message = new HashMap<>();
		message.put("room", 1);
		message.put("content", "방에 입장하였습니다.");
		int result = chatDao.insertMessage(4, message);
		System.out.println(result);
	}

}
