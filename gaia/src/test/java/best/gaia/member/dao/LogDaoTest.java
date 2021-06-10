package best.gaia.member.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class LogDaoTest {
	@Inject
	LogDao logDao;
	
	@Test
	public void testInsertLog() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetLogList() {
		Map<String, Object> log = new HashMap<>();
		log.put("ip", "192.168.0.1");
		int result = logDao.insertLog(1, log);
		System.out.println(result);
		fail("Not yet implemented");
	}

}
