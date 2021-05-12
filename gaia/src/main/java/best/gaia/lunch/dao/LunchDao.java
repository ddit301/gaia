package best.gaia.lunch.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.MemberVO;


@Repository
public interface LunchDao {
	public MemberVO selectUser(String user_id);
	public List<MemberVO> selectUserList();
}
