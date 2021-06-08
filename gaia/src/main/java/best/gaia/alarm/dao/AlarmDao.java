package best.gaia.alarm.dao;

import java.util.Map;

public interface AlarmDao {
	
	public int insertAlarm(int mem_no, Map<String,Object> alarm);
	
}
