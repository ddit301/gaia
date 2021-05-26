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
import best.gaia.vo.MemberVO;

@Service("authService")
public class AuthenticateService implements UserDetailsService {
	private static final Logger logger = LoggerFactory.getLogger(AuthenticateService.class);
	@Inject
	private MemberDao dao;

	@Inject
	private PasswordEncoder passwordEncoder;

	/**
	 * mem_id로 검색한 memberVO객체
	 */
	@Override
	public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {
		logger.info("loadUserByUsername start");
		MemberVO memberDetails = dao.selectMemberForAuth(mem_id);
		if (memberDetails == null) {
			throw new UsernameNotFoundException(mem_id);
		}
		return memberDetails;
	}

}
