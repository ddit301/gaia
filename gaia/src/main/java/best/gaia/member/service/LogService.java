package best.gaia.member.service;

import javax.servlet.http.HttpServletRequest;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

public interface LogService {
	public ServiceResult insertLog(int mem_no, HttpServletRequest req);
}
