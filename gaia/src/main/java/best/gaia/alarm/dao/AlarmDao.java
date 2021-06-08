package best.gaia.alarm.dao;

import java.util.List;
import java.util.Map;

public interface AlarmDao {
	
	public int insertAlarm(int mem_no, Map<String,Object> alarm);
	public List<Map<String, Object>> getAlarmList(int mem_no);
	
}
