package best.gaia.admin.service;

import java.util.List;

import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

public interface AdminService {
	
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveAllMember();
	
}
