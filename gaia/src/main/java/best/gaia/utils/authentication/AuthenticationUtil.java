package best.gaia.utils.authentication;


import org.springframework.security.core.Authentication;

import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.MemberVO;

public class AuthenticationUtil {
	static public int getMemberNoFromAuthentication(Authentication authentication) {
		if(authentication == null) {
			throw new UnauthorizedException();
		}
		
		MemberVO member = (MemberVO) authentication.getPrincipal();
		if(member == null) {
			throw new UnauthorizedException();
		}
		
		int mem_no = member.getMem_no();
		return mem_no;
	}
}
