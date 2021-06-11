package best.gaia.member.dao;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class MemberDaoTest {

	@Inject
	MemberDao dao;
	@Inject
	LogDao logDao;
	
	@Inject
	WebApplicationContext container;
	
//	@Test
//	public void testSelectMemberDetailByNo() {
//		MemberVO member = dao.selectMemberDetailByNo(41);
//		assertNotNull(member);
//	}
//	@Test
//	public void testmemberStatusList() {
//		List<Map<String,Object>> member = dao.memberStatusList();
//		System.out.println(member);
//		assertNotNull(member);
//	}
	@Test
	public void testMemberLog() {
		Map<String, Object> log = new HashMap<>();
		log.put("ip", "192.168.0.1");
		int result = logDao.insertLog(1, log);
		System.out.println(result);
	}
}
