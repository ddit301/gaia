package best.gaia.admin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;


@Repository
public interface AdminDao {
	
	public int selectBoardCount(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> selectBoardList(PagingVO<MemberVO> pagingVO);
	
}
