package best.gaia.member.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import best.gaia.member.dao.MemberDao;
import best.gaia.provider.dao.ProviderDao;
import best.gaia.vo.MemberVO;
import best.gaia.vo.ProviderVO;

@Service("detailService")
public class AuthenticateService implements UserDetailsService {
	private static final Logger logger = LoggerFactory.getLogger(AuthenticateService.class);
	@Inject
	private MemberDao memberDao;
	@Inject
	private ProviderDao providerDao;

	/**
	 * mem_id로 검색한 memberVO객체
	 */
	@Override
	public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {
		logger.info("loadUserByUsername start");
		MemberVO member = memberDao.selectMemberForAuth(mem_id);
		ProviderVO provider = providerDao.selectProviderForAuth(mem_id);

		if (member != null) {
			return member;
		} else if (provider != null) {
			return provider;
		} else {
			throw new UsernameNotFoundException(mem_id);
		}
	}

}