package best.gaia.alarm.service;

import java.util.List;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AlarmVO;
import best.gaia.vo.IssueVO;

public interface AlarmService {
	
	public ServiceResult insertIssueCommentAlarm(IssueVO issue);
	public List<AlarmVO> selectAlarmList(int mem_no);
	public int updateUnreadAlarms(int mem_no);
	
}
