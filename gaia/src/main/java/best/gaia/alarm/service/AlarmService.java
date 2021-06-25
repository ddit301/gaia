package best.gaia.alarm.service;

import java.util.List;
import java.util.Map;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AlarmVO;
import best.gaia.vo.IssueVO;

public interface AlarmService {
	
	public ServiceResult insertIssueCommentAlarm(IssueVO issue);
	public ServiceResult insertInviteAlarm(Map<String, Object> inviteInfo);
	public List<AlarmVO> selectAlarmList(int mem_no);
	public int updateUnreadAlarms(int mem_no);
	
}
