package best.gaia.project.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import best.gaia.TestWebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@TestWebAppConfiguration
public class RepositoryDaoTest {
	
	@Inject 
	RepositoryDao dao;

	@Test
	public void testSelectRepositoryList() {
		
		List<Map<String, Object>> repositories = dao.selectRepositoryList(1);
		
		int i = 1;
		for(Map<String, Object> repository : repositories ) {
			System.out.println(i++ + "번째 저장소");
			System.out.println(repository);
		}
		
		
	}

}
