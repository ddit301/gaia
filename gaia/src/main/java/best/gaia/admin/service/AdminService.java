package best.gaia.admin.service;

import java.util.List;

import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

public interface AdminService {
	
	public int retrieveBoardCount(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveBoardList(PagingVO<MemberVO> pagingVO);
	
}
