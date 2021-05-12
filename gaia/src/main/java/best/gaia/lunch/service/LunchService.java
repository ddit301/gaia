package best.gaia.lunch.service;

import java.util.List;

import best.gaia.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

public interface LunchService {
	public ServiceResult authenticate(MemberVO user);
	public List<MemberVO> selectUserList();
	public MemberVO selectUser(String user_id);
	
}
