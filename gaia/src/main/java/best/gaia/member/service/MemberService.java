package best.gaia.member.service;

import best.gaia.vo.MemberVO;

public interface MemberService {
//	public ServiceResult authenticate(MemberVO user);
//	public List<MemberVO> selectUserList();
//	public MemberVO selectUser(String user_id);
	public int enrollMember(MemberVO member);
}
