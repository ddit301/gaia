package best.gaia.member.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import best.gaia.member.dao.MemberDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

@Service("authService")
public class AuthenticateServiceImpl implements AuthenticateService, UserDetailsService {
	private static final Logger logger = LoggerFactory.getLogger(AuthenticateServiceImpl.class);
	@Inject
	private MemberDao dao;

	@Inject // shaPasswordEncoder를 받아야한다.
	private PasswordEncoder encoder;

	/**
	 * mem_id로 검색한 memberVO객체
	 */
	@Override
	public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {
		MemberVO memberDetails = dao.selectMemberForAuth(mem_id);
		return memberDetails;
	}

	/**
	 * 입력한 email과 pw가 일치하는 지 
	 */
	@Override
	public ServiceResult authenticate(MemberVO member) {
		/**
		 * savedMember: DB에서 찾아온 memberVO객체
		 */
		MemberVO savedMember = dao.selectMemberForAuth(member.getMem_id());
		ServiceResult result = null;
		if (savedMember != null) {
//			PW 확인 
			try {
//				String encodedPass = CryptoUtil.sha512(inputPass);
//				String savedPass = savedMember.getMem_pass();

//				String encodedPass = encoder.encode(inputPass);
//				String encodedPass = BCrypt.hashpw(inputPass, BCrypt.gensalt(10));

//				savedPass.equals(encodedPass);
				if (encoder.matches(member.getMem_pass(), savedMember.getMem_pass())) {
//					try {
//						BeanUtils.copyProperties(member, savedMember);
//					} catch (IllegalAccessException | InvocationTargetException e) {
//						throw new RuntimeException(e);
//					}
					result = ServiceResult.OK;
				} else {
					result = ServiceResult.INVALIDPASSWORD;
				}
			} catch (Exception e) {
				logger.error("", e);
				result = ServiceResult.FAIL;
			}
		} else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

}
