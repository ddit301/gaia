package best.gaia.provider.dao;

import org.springframework.stereotype.Repository;

import best.gaia.vo.MemberVO;
import best.gaia.vo.ProviderVO;


@Repository
public interface ProviderDao {
//	public MemberVO selectUser(String user_id);
//	public List<MemberVO> selectUserList();
	/**
	 * PK 를 기준으로 한명의 회원 조회(인증용)
	 * @param mem_id(e-mail)
	 * @return 존재하지 않는 경우, null 반환.
	 */
	public ProviderVO selectProviderForAuth(String prov_id);
	

}
