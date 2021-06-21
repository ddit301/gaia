package best.gaia.calendar.dao;

import static org.junit.Assert.*;

import java.util.Calendar;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.calendar.service.CalendarService;
import best.gaia.chat.dao.ElasticChatDao;
import best.gaia.chat.dao.OracleChatDao;
import best.gaia.chat.service.ChatService;
import best.gaia.chat.service.ChatServiceImplTest;
import best.gaia.vo.ChatRoomVO;

/**
 * @author Eisen
 * @since Jun 21, 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * Jun 21, 2021  Eisen    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class CalendarDaoTest {
	private static final Logger logger = LoggerFactory.getLogger(ChatServiceImplTest.class);
	@Inject
	CalendarDao dao;
	
	@Inject
	CalendarService service;
	@Inject
	WebApplicationContext container;

	@Test
	public void testSelectIssuesByProj_no() {
		service.selectMilestoneIssuesByProj_no(1);
	}

	/**
	 * Test method for {@link best.gaia.calendar.dao.CalendarDao#selectMilestoneByProj_no(int)}.
	 */
//	@Test
	public void testSelectMilestoneByProj_no() {
		fail("Not yet implemented");
	}

	/**
	 * Test method for {@link best.gaia.calendar.dao.CalendarDao#labelList(int)}.
	 */
//	@Test
	public void testLabelList() {
		fail("Not yet implemented");
	}

}
