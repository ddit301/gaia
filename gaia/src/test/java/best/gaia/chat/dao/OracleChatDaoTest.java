package best.gaia.chat.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.vo.ChatRoomVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class OracleChatDaoTest {

	@Inject
	OracleChatDao dao;
	
	@Inject
	WebApplicationContext container;

	@Test
	public void test() {
		List<ChatRoomVO> chatVO = dao.selectMemberChatRoomList(2);
		int i = 0;
		for(ChatRoomVO room : chatVO) {
			i++;
			System.out.println(i+"번 : "+room.toString());
		}
	}
}
