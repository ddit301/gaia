package best.gaia.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.MemberVO;


@Repository
public interface MemberDao {
	public MemberVO selectUser(String user_id);
	public List<MemberVO> selectUserList();
	public int insertMember(MemberVO member);
}
