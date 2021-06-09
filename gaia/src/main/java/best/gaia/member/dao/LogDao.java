package best.gaia.member.dao;

import java.util.List;
import java.util.Map;

public interface LogDao {

	public int insertLog(int mem_no, Map<String,Object> log);
//	public List<Map<String, Object>> getAlarmList(int mem_no);

}
