package best.gaia.member.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.MemberVO;
import best.gaia.vo.ProjMemVO;

@Repository
public interface MemberDao {
//	public MemberVO selectUser(String user_id);
//	public List<MemberVO> selectUserList();
	/**
	 * PK 를 기준으로 한명의 회원 조회(인증용)
	 * 
	 * @param mem_id(e-mail)
	 * @return 존재하지 않는 경우, null 반환.
	 */
	public MemberVO selectMemberForAuth(String mem_id);

	/**
	 * 회원 정보 상세 조회(profile)
	 * @param mem_id(e-mail)
	 * @return 존재하지 않는 경우, null 반환.
	 */
	public MemberVO selectMemberDetail(String mem_id);

	/**
	 * 회원 정보 상세 조회(profile+project+issues)
	 * @param mem_no(int)
	 * @return 존재하지 않는 경우, null 반환.
	 */
	public MemberVO selectMemberDetailProject_issue(int mem_no);
	/**
	 * 회원 정보 상세 조회(profile)
	 * @param mem_no(int)
	 * @return 존재하지 않는 경우, null 반환.
	 */
	public MemberVO selectMemberDetailByNo(int mem_no);
	public List<Map<String, Object>> memberStatusList();

	/**
	 * 신규 등록
	 * 
	 * @param member
	 * @return 등록된 row count > 0 성공
	 */
	public int insertMember(MemberVO member);

	/**
	 * 회원 정보 수정
	 * 
	 * @param member
	 * @return 수정된 row count > 0 성공
	 */
	public int updateMember(MemberVO member);

	
	/**
	 * 회원 정보 삭제
	 * 
	 * @param mem_id
	 * @return 삭제된 row count > 0 성공
	 */
	public int deleteMember(int mem_no);
	
	public List<ProjMemVO> selectProjectMembers(Map<String,Object> param);
}
