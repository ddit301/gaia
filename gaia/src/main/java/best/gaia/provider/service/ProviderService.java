package best.gaia.provider.service;

import java.util.List;

import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

public interface ProviderService {
	
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveAllMember();
	
}
