package best.gaia.alarm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.search.sort.SortOrder;
import org.springframework.stereotype.Component;

import best.gaia.utils.ElasticUtil;

@Component
public class AlarmDaoImpl implements AlarmDao {
	
	private ElasticUtil elastic;
	private static AlarmDaoImpl self;
	
	private AlarmDaoImpl() {
		elastic = ElasticUtil.getInstance();
	}
	
	public static AlarmDaoImpl getInstance() {
		if(self == null)
			self = new AlarmDaoImpl();
		return self;
	}
	
	public int insertAlarm(int mem_no, Map<String,Object> alarm) {
		alarm.put("mem_no", mem_no);
		String index = "alarm";
		return elastic.insert(index, null, alarm);
	}
	
	public List<Map<String, Object>> getAlarmList(int mem_no){
		String index = "alarm";
		
		Map<String,Object> query = new HashMap<>();
		query.put("mem_no",mem_no);
		
		Map<String,SortOrder> sort = new HashMap<>();
		sort.put("date",SortOrder.DESC);
		
		return elastic.simpleSearch(index, query, sort);
		
	}
	
}
