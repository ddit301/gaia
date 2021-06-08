package best.gaia.utils;


import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;

import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.MemberUserDetails;
import best.gaia.vo.MemberVO;

public class SessionUtil {
	static public int getMemberNoFromAuthentication(Authentication authentication) {
		if(authentication == null) {
			throw new UnauthorizedException();
		}
		
		MemberVO member = ((MemberUserDetails) authentication.getPrincipal()).getAdaptee();
		if(member == null) {
			throw new UnauthorizedException();
		}
		
		return member.getMem_no();
	}
	
	static public Integer getProjNoFromSession(HttpSession session){
		Integer proj_no = (Integer)session.getAttribute("proj_no");
		if(proj_no == null) {
			throw new UnauthorizedException();
		}
		return proj_no;
	}
}
