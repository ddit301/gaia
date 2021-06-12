package best.gaia.main.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

@Service
public class FailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(
			HttpServletRequest request
			, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String mem_id = request.getParameter("mem_id");
		
		request.setAttribute("message"
				,"$$$"+ mem_id + "로 로그인 하는데 실패했습니다. 아이디와 비밀번호를 확인해주세요.$$$");
		
		// 로그인 페이지로 다시 이동
		RequestDispatcher dispatcher = request.getRequestDispatcher("/signin");
		dispatcher.forward(request, response);
//		response.sendRedirect("/signin");
		
	}

}
