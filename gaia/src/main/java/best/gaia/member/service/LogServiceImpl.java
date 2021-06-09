package best.gaia.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import best.gaia.alarm.dao.AlarmDao;
import best.gaia.chat.dao.ChatDao;
import best.gaia.member.dao.LogDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

@Service
public class LogServiceImpl implements LogService{
	@Inject
	private LogDao dao;

	@Override
	public ServiceResult insertLog(int mem_no, HttpServletRequest req) {
		Map<String, Object> log = new HashMap<>();
		log.put("ip", req.getRemoteAddr());
		int result = dao.insertLog(mem_no, log);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<Map<String, Object>> selectLogList(int mem_no) {
		return dao.getLogList(mem_no);
	}

}
