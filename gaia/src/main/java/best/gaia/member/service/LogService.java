package best.gaia.member.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

public interface LogService {
	public ServiceResult insertLog(int mem_no, HttpServletRequest req);
	public List<Map<String, Object>> selectLogList(int mem_no);
}
