package best.gaia.chat.service;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

public interface ChatService {
	public ServiceResult insertMemberMessege(MemberVO member);
}
