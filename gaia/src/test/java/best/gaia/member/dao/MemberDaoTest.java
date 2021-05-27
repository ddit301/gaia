package best.gaia.member.dao;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class MemberDaoTest {

	@Inject
	MemberDao dao;
	
	@Inject
	WebApplicationContext container;
	
	@Test
	public void testSelectMemberDetailByNo() {
		MemberVO member = dao.selectMemberDetailByNo(41);
		assertNotNull(member);
		
	}

}
