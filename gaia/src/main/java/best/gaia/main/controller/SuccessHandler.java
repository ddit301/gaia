package best.gaia.main.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import best.gaia.utils.CookieUtil;
import best.gaia.vo.MemberUserDetails;
import best.gaia.vo.MemberVO;

public class SuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		MemberVO member = ((MemberUserDetails) authentication.getPrincipal()).getAdaptee();

		if (savedRequest == null) {
			// Member로 로그인 성공시 cookie에 접속 회원의 mem_no와 mem_pic_file_name을 쿠키에 넣어둡니다.
			CookieUtil.addCookie("mem_no", String.valueOf(member.getMem_no()), response);
			CookieUtil.addCookie("mem_id", member.getMem_id(), response);
			CookieUtil.addCookie("mem_pic_file_name",
					member.getMem_pic_file_name()==null? "default" : member.getMem_pic_file_name(), response);
			
			redirectStratgy.sendRedirect(request, response, "/" + member.getMem_id() + "/overview");

			return;
		}
		String targetUrlParameter = getTargetUrlParameter();
		if (isAlwaysUseDefaultTargetUrl()
				|| (targetUrlParameter != null && StringUtils.hasText(request.getParameter(targetUrlParameter)))) {
			requestCache.removeRequest(request, response);
			super.onAuthenticationSuccess(request, response, authentication);

			return;
		}
	}

	@Override
	public void setRequestCache(RequestCache requestCache) {
		super.setRequestCache(requestCache);
	}

}
