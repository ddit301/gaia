package best.gaia.member.controller;

import java.util.HashMap;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;

import best.gaia.member.service.MemberService;
import best.gaia.vo.KakaoService;
import best.gaia.vo.MemberVO;

@Controller
public class APILoginController {
	
	@Inject
	private MemberService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	private static final Logger logger = LoggerFactory.getLogger(APILoginController.class);
	
	@Autowired
	private KakaoService kakaoService;
	
	final ObjectMapper mapper = new ObjectMapper();
	
	@Inject
	@Named("authenticationManager")
	AuthenticationManager authenticationManager;
	
	
	//kakao login
	@RequestMapping("/oauth/kakao")
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, @RequestParam(value="scope", required = false) String scope) throws Exception {
        String access_Token = kakaoService.getAccessToken(code);
        HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
        Authentication authentication = new UsernamePasswordAuthenticationToken("admin", "admin");///
        Authentication newAuthentication = authenticationManager.authenticate(authentication);
         SecurityContextHolder.getContext().setAuthentication(newAuthentication);
//        MemberVO member = mapper.convertValue(userInfo, MemberVO.class);
        
//        <what u can get>
//        
//        code String	토큰 받기 요청에 필요한 인가 코드	O
//        token_type	String	토큰 타입, bearer로 고정	O
//        access_token	String	사용자 액세스 토큰 값	O
//        expires_in	Integer	액세스 토큰 만료 시간(초)	O
//        refresh_token	String	사용자 리프레시 토큰 값	O
//        refresh_token_expires_in	Integer	리프레시 토큰 만료 시간(초)	O
//        scope	String	인증된 사용자의 정보 조회 권한 범위. 범위가 여러 개일 경우, 공백으로 구분	X   email
//        
//        <ex>
//        HTTP/1.1 200 OK
//        Content-Type: application/json;charset=UTF-8
//        {
//            "token_type":"bearer",
//            "access_token":"{ACCESS_TOKEN}",
//            "expires_in":43199,
//            "refresh_token":"{REFRESH_TOKEN}",
//            "refresh_token_expires_in":25184000,
//            "scope":"account_email profile"
//        }
        
        return "redirect:/";
	}
	
	
	
	// github login
	@RequestMapping("/signout/success")
	public String logOut(HttpSession session) throws Exception {
		if(session.isNew()) {
			return "redirect:/";
		} else {
			return "member/overview";
		}
		
	}
	
	// github login
	@RequestMapping("/oauth/github")
	public String githubLogin(@RequestParam(value = "code", required = false) String code, @RequestParam(value="scope", required = false) String scope) throws Exception {
        String access_Token = kakaoService.getAccessToken(code);
        HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
        MemberVO member = mapper.convertValue(userInfo, MemberVO.class);
	
        return "member/overview";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	@RequestMapping(value="/login/login.do", method = RequestMethod.GET)
//	public String loginPage() {
//		return "member/login";
//	}
//	
//	@RequestMapping(value="/login/loginCheck.do", method = RequestMethod.POST)
//	public String loginCheck(
//			@RequestParam String user_id
//			,@RequestParam String user_pass
//			,@RequestParam(value="saveId", required=false) String saveId
//			,HttpSession session
//			,HttpServletRequest req
//			,HttpServletResponse resp
//			) {
//		
//
//		if("saveId".equals(saveId)) {	// 쿠키에 아이디 하루동안 저장
//			Cookie savedIdCookie = new Cookie("savedId",user_id);
//			savedIdCookie.setPath(String.format("%s",application.getContextPath()));
//			savedIdCookie.setMaxAge(1*24*60*60);
//			resp.addCookie(savedIdCookie);
//		}else {	// 저장된 아이디 쿠키 삭제
//			Cookie savedIdCookie = new Cookie("savedId",null);
//			savedIdCookie.setPath(String.format("%s",application.getContextPath()));
//			savedIdCookie.setMaxAge(0);
//			resp.addCookie(savedIdCookie);
//		}
//		
//		boolean valid = validate(user_id, user_pass);
//		
//		MemberVO user = new MemberVO();
//		user.setMem_id(user_id);
//		user.setMem_pass(user_pass);
//		
//		String view = null;
//		String message = "";
//		
//		if(valid) {
//		// 인증 (id == password)
//			ServiceResult result = service.authenticate(user);
//			switch(result) {
//			case OK:
//				// 로그인 성공시 쿠키에 접속한 아이디 저장
//				Cookie idCookie = new Cookie("loginId",user.getMem_id());
//				idCookie.setMaxAge(1*24*60*60);
//				idCookie.setPath(String.format("%s",application.getContextPath()));
//				resp.addCookie(idCookie);
//				// 로그인 성공시 쿠키에 접속자 이름 저장
//				Cookie nameCookie = new Cookie("loginName",user.getMem_name());
//				nameCookie.setMaxAge(1*24*60*60);
//				nameCookie.setPath(application.getContextPath());
//				resp.addCookie(nameCookie);
//				
//				view = "redirect:/blank.jsp";
//				session.setAttribute("authUser", user);
//				break;
//			case NOTEXIST:
//				view = "redirect:/login/login.do";
//				message = "아이디 오류";
//				break;
//			case INVALIDPASSWORD:
//			default:
//				// 인증 실패
//				view = "redirect:/login/login.do";
//				message = "비번 오류";
//				break;
//			}
//			
//		}else {
//			// 1)검증
//			view = "redirect:/login/login.do";
//			message = "아이디나 비번 누락";
//		}
//		
//		session.setAttribute("message", message);
//		
//		return view;
//	}
//	
//	private boolean validate(String id, String pass) {
//		boolean valid = true;
//		valid = !(id == null || id.isEmpty() || pass==null || pass.isEmpty());
//		return valid;
//	}
	

}


