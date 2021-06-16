package best.gaia.member.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.member.dao.MemberDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

//import kr.or.ddit.utils.CryptoUtil;
@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDao dao;
//	@Inject
//	private AuthenticateService authService;

	@Inject
	private PasswordEncoder passwordEncoder;

	@Override
	public Integer retrieveMember(String mem_id) {
		int count = dao.selectMemberID(mem_id);
//		if (count == 0) {
//			throw new RuntimeException("해당 이메일을 등록한 회원이 존재하지 않음.");
//		}
		return count;
	}
	
	@Override
	public MemberVO retrieveMemberByNo(int mem_no) {
		MemberVO savedMember = dao.selectMemberDetailByNo(mem_no);
		if (savedMember == null) {
			throw new RuntimeException("해당 mem_no 회원이 존재하지 않음.");
		}
		return savedMember;
	}

	@Override
	public MemberVO retrieveMemberProjectIssue(int mem_no) {
		MemberVO savedMember = dao.selectMemberDetailProject_issue(mem_no);
		if (savedMember == null) {
			throw new RuntimeException("해당 mem_no 회원이 존재하지 않음.");
		}
		return savedMember;
	}

	
	@Override
	@Transactional
	public ServiceResult enrollMember(MemberVO member) {
		ServiceResult result = ServiceResult.FAIL;
		if (dao.selectMemberForAuth(member.getMem_id()) == null) {
			String inputPass = member.getMem_pass();
			try {
				String encodedPass = passwordEncoder.encode(inputPass);
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
	@Transactional
	public ServiceResult modifyMember(MemberVO member) {
		ServiceResult result= ServiceResult.OK; //인증 로직 
//		ServiceResult result = authService.authenticate(new MemberVO(member.getMem_id(), member.getMem_pass()));
		if (ServiceResult.OK.equals(result)) {
			if(member.getMem_pass() !=null) {
				String inputPass = member.getMem_pass();
				String encodedPass = passwordEncoder.encode(inputPass);
				member.setMem_pass(encodedPass);
			}
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
	@Transactional
	public ServiceResult modifyMemberPass(MemberVO member, String old_pass) {
		ServiceResult result= ServiceResult.OK; //인증 로직 
//		ServiceResult result = authService.authenticate(new MemberVO(member.getMem_id(), member.getMem_pass()));
		if (ServiceResult.OK.equals(result)) {
			result = ServiceResult.NOTEXIST;
			if(member.getMem_pass() !=null && !old_pass.isEmpty()) {
				result = ServiceResult.INVALIDPASSWORD;
				MemberVO dbMember = dao.selectMemberDetailByNo(member.getMem_no());
				if(passwordEncoder.matches(old_pass, dbMember.getMem_pass())) {
					String inputPass = member.getMem_pass();
					String encodedPass = passwordEncoder.encode(inputPass);
					member.setMem_pass(encodedPass);
					int rowcnt = dao.updateMember(member);
					if (rowcnt > 0) {
						result = ServiceResult.OK;
					} else {
						result = ServiceResult.FAIL;
					}
				}
			}
		}
		return result;
	}
	

	@Override
	@Transactional
	public ServiceResult removeMember(MemberVO member) {
		retrieveMember(member.getMem_id());
		ServiceResult result= ServiceResult.OK; //인증 로직 
//		ServiceResult result = authService.authenticate(new MemberVO(member.getMem_id(), member.getMem_pass()));
		if (ServiceResult.OK.equals(result)) {
			int rowcnt = dao.deleteMember(member.getMem_no());
			if (rowcnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAIL;
			}
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> memberStatusList() {
		return dao.memberStatusList();
	}

}
