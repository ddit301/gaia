package best.gaia.calendar.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.calendar.service.CalendarService;
import best.gaia.chat.service.ChatServiceImplTest;
import best.gaia.vo.IssueVO;

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

//	@Test
	public void testSelectIssuesByProj_no() {
		service.selectMilestoneIssuesByProj_no(1);
	}

	/**
	 * Test method for {@link best.gaia.calendar.dao.CalendarDao#selectMilestoneByProj_no(int)}.
	 */
//	@Test
	public void testUpdateIssue() {
		Map<String, Object> issueSidStatus = new HashedMap();
		issueSidStatus.put("issue_sid", 122);
		issueSidStatus.put("issue_status", 1);
		int result = dao.updateIssueStatus(issueSidStatus);
		System.out.println(result);
	}

	@Test
	public void testUpdateDate() {
		Map<String, Object> milestonSid = new HashedMap();
		milestonSid.put("start_date",  String.valueOf("2021-06-02"));
		milestonSid.put("end_date", String.valueOf("2021-06-21"));
		milestonSid.put("sid", 11);
		
		int result = dao.updateMilestoneDate(milestonSid);
//		System.out.println(String.valueOf(issueSid.get("start_date")));
	}
//	@Test
	public void testSelect() {
		List<IssueVO> issueList = dao.selectIssuesByProj_no(1);
		IssueVO issue = issueList.get(0);
		String date = issue.getIssue_end_date();
		
		
	}

}
