package best.gaia.member.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import best.gaia.member.dao.MemberDao;
import best.gaia.vo.MemberUserDetails;
import best.gaia.vo.MemberVO;

@Service
public class AuthenticateService implements UserDetailsService {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthenticateService.class);
	
	@Inject
	private MemberDao dao;

	/**
	 * mem_id로 검색한 memberVO객체
	 */
	@Override
	public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {
		
		// 멤버 정보 select
		MemberVO memberInfo = dao.selectMemberForAuth(mem_id);
		
		// 해당 멤버가 없으면 null 처리
		if(memberInfo == null) {
			return null;
			
		}else {
			// 멤버를 찾았을 경우에 유저 생성해 반환
			return new MemberUserDetails(memberInfo);
		}
		
		
	}

}