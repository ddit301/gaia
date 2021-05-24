package best.gaia.member.service;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

public interface IAuthenticateService {
	/**
	 * 인증 결과
	 * 
	 * @param member(mem_id, mem_pass만으로 검색)
	 * @return OK, FAIL, NOTEXIST, INVALIDPASSWORD, PKDUPLICATED
	 */
	public ServiceResult authenticate(MemberVO member);
}
