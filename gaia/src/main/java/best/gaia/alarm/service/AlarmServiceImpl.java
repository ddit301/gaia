package best.gaia.alarm.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.alarm.dao.AlarmDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;

@Service
public class AlarmServiceImpl implements AlarmService {
	
	@Inject
	private AlarmDao dao;

	@Override
	public ServiceResult insertIssueCommentAlarm(IssueVO issue) {
		IssueHistoryVO issueHistory = issue.getHistoryList().get(0);
		Map<String, Object> alarm = new HashMap<>();
		alarm.put("alarm_type", "IC");
		alarm.put("url", issue.getUrl());
		alarm.put("proj_usernick", issueHistory.getHistoryWriter().getMem_nick());
		alarm.put("issue_title",issue.getIssue_title());
		alarm.put("issue_his_cont",issueHistory.getIssue_his_cont());
		int result = dao.insertAlarm(issue.getMem_no(), alarm);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
