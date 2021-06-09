package best.gaia.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.search.sort.SortOrder;
import org.springframework.stereotype.Component;

import best.gaia.utils.ElasticUtil;

@Component
public class LogDaoImpl implements LogDao{
	private ElasticUtil elastic;

	@Override
	public int insertLog(int mem_no, Map<String, Object> log) {
		String index = "log";
		log.put("mem_no", mem_no);
		elastic = ElasticUtil.getInstance();
		int result = elastic.insert(index, null, log);
		
		return result;
	}
}
