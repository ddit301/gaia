package best.gaia.provider.service;

import java.util.List;

import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProviderVO;

public interface ProviderService {
	
	public ProviderVO retrieveProvider(String prov_id);
	
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveAllMember();
	
}
