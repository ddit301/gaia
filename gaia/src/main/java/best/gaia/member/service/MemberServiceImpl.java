package best.gaia.member.service;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import best.gaia.member.dao.MemberDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

//import kr.or.ddit.utils.CryptoUtil;
@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDao dao;
	@Inject
	private AuthenticateService authService;

	@Inject // shaPasswordEncoder를 받아야한다.
	private PasswordEncoder encoder;

	@Override
	public MemberVO retrieveMember(String mem_id) {
		MemberVO savedMember = dao.selectMemberDetail(mem_id);
		if (savedMember == null) {
			throw new RuntimeException("해당 이메일을 등록한 회원이 존재하지 않음.");
		}
		return savedMember;
	}

	@Override
	public ServiceResult enrollMember(MemberVO member) {
		ServiceResult result = null;
		if (dao.selectMemberForAuth(member.getMem_id()) == null) {
			String inputPass = member.getMem_pass();
			try {
//				String encodedPass = CryptoUtil.sha512(inputPass);
//				String encodedPass = BCrypt.hashpw(inputPass, BCrypt.gensalt(10));
				String encodedPass = encoder.encode(inputPass);
				member.setMem_pass(encodedPass);
				int rowcnt = dao.insertMember(member);
				if (rowcnt > 0) {
					result = ServiceResult.OK;
				} else {
					result = ServiceResult.FAIL;
				}
			} catch (Exception e) {
				result = ServiceResult.FAIL;
			}
		} else {
			result = ServiceResult.PKDUPLICATED;
		}
		return result;
	}

	@Override
	public ServiceResult modifyMember(MemberVO member) {
		retrieveMember(member.getMem_id());
		ServiceResult result = authService.authenticate(new MemberVO(member.getMem_id(), member.getMem_pass()));
		if (ServiceResult.OK.equals(result)) {
			int rowcnt = dao.updateMember(member);
			if (rowcnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAIL;
			}
		}
		return result;
	}

	@Override
	public ServiceResult removeMember(MemberVO member) {
		retrieveMember(member.getMem_id());
		ServiceResult result = authService.authenticate(new MemberVO(member.getMem_id(), member.getMem_pass()));
		if (ServiceResult.OK.equals(result)) {
			int rowcnt = dao.deleteMember(member.getMem_id());
			if (rowcnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAIL;
			}
		}
		return result;
	}

}
