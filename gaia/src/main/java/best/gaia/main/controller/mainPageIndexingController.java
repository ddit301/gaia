package best.gaia.main.controller;

import java.util.HashMap;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;

import best.gaia.vo.KakaoService;
import best.gaia.vo.MemberVO;

/**
 * 
 * @author Robin
 * @since 2021. 5. 14
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 2021. 5. 14  Robin    Initial Commit
 * Copyright (c) 2021 by team SEED All right reserved
 *      </pre>
 */

@Controller
public class mainPageIndexingController {
	@Autowired
	private KakaoService kakaoService;
	
	final ObjectMapper mapper = new ObjectMapper();

	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(mainPageIndexingController.class);

	@RequestMapping(value = "/intro")
	public String introPage() {
		return "main/intro";
	}

	@RequestMapping(value = "/demo")
	public String demoPage() {
		return "main/demo";
	}

	@RequestMapping(value = "/sales")
	public String salesPage() {
		return "main/sales";
	}

	@RequestMapping(value = "/updates")
	public String updatesPage() {
		return "main/updates";
	}

	@RequestMapping(value = "/signin")
	public String loginPage() {
		return "main/signin";
	}

	@RequestMapping("/oauth")
	public String login(@RequestParam(value = "code", required = false) String code, @RequestParam(value="scope", required = false) String scope) throws Exception {
        String access_Token = kakaoService.getAccessToken(code);
        HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
        MemberVO member = mapper.convertValue(userInfo, MemberVO.class);
        
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
        
        return "/myPage";
	}

	@RequestMapping(value = "/signup")
	public String logoutPage() {
		return "main/signup";
	}

	@RequestMapping(value = "/CS")
	public String CSPage() {
		return "main/CS";
	}

	

}
