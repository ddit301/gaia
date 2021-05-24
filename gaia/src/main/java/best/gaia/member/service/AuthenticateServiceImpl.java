package best.gaia.member.service;

import java.lang.reflect.InvocationTargetException;

import javax.inject.Inject;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import best.gaia.member.dao.MemberDao;
import best.gaia.utils.CryptoUtil;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

@Service("authService")
public class AuthenticateServiceImpl implements IAuthenticateService, UserDetailsService {
	private static final Logger logger = LoggerFactory.getLogger(AuthenticateServiceImpl.class);
	@Inject
	private MemberDao dao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO savedMember = dao.selectMemberForAuth(username);
		return savedMember;
	}

	@Override
	public ServiceResult authenticate(MemberVO member) {
		MemberVO savedMember = dao.selectMemberForAuth(member.getMem_id());
		ServiceResult result = null;
		if (savedMember != null) {
			String inputPass = member.getMem_pass();
			try {
				String encodedPass = CryptoUtil.sha512(inputPass);
				String savedPass = savedMember.getMem_pass();
				if (savedPass.equals(encodedPass)) {
					try {
						BeanUtils.copyProperties(member, savedMember);
					} catch (IllegalAccessException | InvocationTargetException e) {
						throw new RuntimeException(e);
					}
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
