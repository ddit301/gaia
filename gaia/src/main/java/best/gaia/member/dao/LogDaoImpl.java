package best.gaia.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.elasticsearch.search.sort.SortOrder;
import org.springframework.stereotype.Component;

import best.gaia.utils.ElasticUtil;

@Component
public class LogDaoImpl implements LogDao{
	@Inject
	private ElasticUtil elastic;

	@Override
	public int insertLog(int mem_no, Map<String, Object> log) {
		String index = "log";
		log.put("mem_no", mem_no);
		int result = elastic.insert(index, log);
		
		return result;
	}

	@Override
	public List<Map<String, Object>> getLogList(int mem_no) {
		String index = "log";
		
		Map<String,Object> query = new HashMap<>();
		query.put("mem_no",mem_no);
		
		Map<String,SortOrder> sort = new HashMap<>();
		sort.put("date",SortOrder.DESC);
		
		
		elastic.simpleSearch(index, query, sort);
		return null;
	}
}
