package best.gaia.alarm.service;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;

public interface AlarmService {
	
	public ServiceResult insertIssueCommentAlarm(IssueVO issue);
	
}
