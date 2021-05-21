package best.gaia.issue.dao;

import static org.junit.Assert.assertNotNull;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.TestWebAppConfiguration;
import best.gaia.vo.IssueVO;

@RunWith(SpringJUnit4ClassRunner.class)
//@TestWebAppConfiguration
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class IssueDaoTest {
	
	@Inject
	private IssueDao dao;
	@Inject
	private WebApplicationContext container;

	@Test
	public void testSelectIssue() {
		IssueVO search = new IssueVO();
		search.setIssue_sid(1);
		IssueVO issue = dao.selectIssue(search);
		assertNotNull(issue);
	}

}
