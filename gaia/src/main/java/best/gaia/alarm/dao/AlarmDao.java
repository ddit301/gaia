package best.gaia.alarm.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.AlarmVO;

@Repository
public interface AlarmDao {
	
	public int insertAlarm(AlarmVO alarm);
	public List<AlarmVO> getAlarmList(int mem_no);
	public int updateUnreadAlarms(int mem_no);
	public int deleteReadAlarms(int mem_no);
	
}
