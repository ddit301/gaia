package best.gaia.chat.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.elasticsearch.search.sort.SortOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.utils.ElasticUtil;
import best.gaia.vo.ChatRoomVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")
@WebAppConfiguration
public class OracleChatDaoTest {

	@Inject
	OracleChatDao dao;
	
	@Inject
	ElasticUtil elastic;
	
	
	@Inject
	WebApplicationContext container;

	@Test
	public void test() {
		String index = "alarm";
		
		Map<String,Object> query = new HashMap<>();
		query.put("mem_no",4);
		
		Map<String,SortOrder> sort = new HashMap<>();
		sort.put("date",SortOrder.DESC);
		
		List<Map<String, Object>> list = elastic.simpleSearch(index, query, sort, null);
		for(Map<String, Object> map : list) {
			System.out.println(map);
		}
	}
}


