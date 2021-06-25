package best.gaia.alarm.service;

import java.util.List;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AlarmVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.ProjectVO;

public interface AlarmService {
	
	public ServiceResult insertIssueCommentAlarm(IssueVO issue);
	public ServiceResult insertInviteAlarm(ProjectVO project);
	public List<AlarmVO> selectAlarmList(int mem_no);
	public int updateUnreadAlarms(int mem_no);
	
}
