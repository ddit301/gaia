package best.gaia.project.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import best.gaia.TestWebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@TestWebAppConfiguration
public class ProjectDaoTest {
	
	@Inject
	private ProjectDao dao;

	@Test
	public void test() {
		String manager_nick = "kkobuk2";
		String project_title = "testproject";
		Map<String, Object> map = new HashMap<>();
		map.put("manager_nick",manager_nick);
		map.put("project_title",project_title);
		Integer projno = dao.getProjNoByNickTitle(map);
//		assertNotNull(projno);
		assertNull(projno);
	}

}
