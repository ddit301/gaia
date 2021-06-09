package best.gaia.chat.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.search.sort.SortOrder;
import org.springframework.stereotype.Component;

import best.gaia.utils.ElasticUtil;

@Component
public class ChatDaoImpl implements ChatDao{
	private ElasticUtil elastic;
	
	public int insertAlarm(int mem_no, Map<String,Object> chat) {
		chat.put("mem_no", mem_no);
		String index = "chat";
		return elastic.insert(index, null, chat);
	}
	
	public List<Map<String, Object>> getAlarmList(int mem_no){
		String index = "chat";
		
		Map<String,Object> query = new HashMap<>();
		query.put("mem_no",mem_no);
		
		Map<String,SortOrder> sort = new HashMap<>();
		sort.put("date",SortOrder.DESC);
		
		return elastic.simpleSearch(index, query, sort);
	}
}
