package best.gaia.member.service;

import java.util.List;
import java.util.Map;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

public interface MemberService {

	/**
	 * 회원 정보 상세 조회(profile)
	 * 
	 * @param mem_id
	 * @return 존재하지 않으면, custom exception 발생
	 */
	public Integer retrieveMember(String mem_id);
	
	/**
	 * 회원 정보 상세 조회(profile)
	 * 
	 * @param mem_id
	 * @return 존재하지 않으면, custom exception 발생
	 */
	public MemberVO retrieveMemberByNo(int mem_no);
	
	/**
	 * 회원 정보 상세 조회(profile_project_issue)
	 * 
	 * @param mem_id
	 * @return 존재하지 않으면, custom exception 발생
	 */
	public MemberVO retrieveMemberProjectIssue(int mem_no);
	
	public List<Map<String, Object>> memberStatusList();
	
	/**
	 * 신규 등록
	 * 
	 * @param member
	 * @return PKDUPLICATED, OK, FAIL
	 */
	public ServiceResult enrollMember(MemberVO member);
	
	/**
	 * 회원 정보 수정
	 * 
	 * @param member
	 * @return 존재하지 않으면, custom exception 발생 INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult modifyMember(MemberVO member);
	
	/**
	 * 회원 정보 수정
	 * 
	 * @param member
	 * @return 존재하지 않으면, custom exception 발생 INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult modifyMemberPass(MemberVO member, String old_pass);
	
	/**
	 * 회원 탈퇴
	 * 
	 * @param member
	 * @return 존재하지 않으면, custom exception 발생 INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult removeMember(MemberVO member);
	
	public ServiceResult sendMessageToMemNo(int mem_no, String message);
	public ServiceResult sendMessagesToProjMember(int proj_no, String message);

}
