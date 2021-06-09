package best.gaia.chat.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import best.gaia.alarm.dao.AlarmDao;
import best.gaia.chat.dao.ChatDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

public class ChatServiceImpl implements ChatService{
	@Inject
	private ChatDao dao;

	@Override
	public ServiceResult insertMemberMessege(MemberVO member) {
//		IssueHistoryVO issueHistory = member.getHistoryList().get(0);
		Map<String, Object> messege = new HashMap<>();
		int result = dao.insertAlarm(member.getMem_no(), messege);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
