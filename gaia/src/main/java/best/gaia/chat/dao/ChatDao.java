package best.gaia.chat.dao;

import java.util.List;
import java.util.Map;

public interface ChatDao {

	public int insertAlarm(int mem_no, Map<String,Object> chat);
	public List<Map<String, Object>> getAlarmList(int mem_no);

}
