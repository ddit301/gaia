package best.gaia.member.controller;

import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.service.MemberService;
import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.MemberVO;
import static best.gaia.utils.SessionUtil.*;

/**
 * 
 * @author Eisen
 * @since May 24, 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * May 24, 2021  Eisen    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 *      </pre>
 * 
 *      admin,view,restapi 다중뎁스.나머지 0뎁
 */

@Controller
@RequestMapping(value = "{mem_id:^(?:(?!admin$|restapi$|echo$|view$|intro$|demo$|sales$|updates$|signin$|signup$|CS$).)*}")
public class MemberUrlMapper {

	@Inject
	private MemberService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(MemberUrlMapper.class);

	@RequestMapping(value = { "", "{pageParam:^(?:(?=help$|overview$)).*}" })
	public String memberMenuOverview(
				@PathVariable String mem_id
				, @PathVariable Optional<String> pageParam
				, Model model, Authentication authentication
			) {
		model.addAttribute("mem_id", mem_id);
		model.addAttribute("pageParam", pageParam.isPresent() ? pageParam.get() : null);

		Integer mem_no = getMemberNoFromAuthentication(authentication);
		MemberVO member = service.retrieveMemberProjectIssue(mem_no);
		model.addAttribute("member", member);
		logger.info("MemberUrlMapper GET 들어옴, need : {}", member);

		return "view/template/project";
	}

	@RequestMapping(value = { "setting",
			"setting/{pageParam:^(?:(?=account$|accountSecurity$|projects$|securityLog$|profile$)).*}" })
	public String memberSetting(
				@PathVariable String mem_id
				, @PathVariable Optional<String> pageParam
				, Model model) {
		model.addAttribute("mem_id", mem_id);
		// false 일 때 null하면 overview로 탐. 그래서 setting을 주어야 profile로 바로 넘어감.
		// true 일 때 setting/을 붙여주어 moveHistory함수 탈 때 /eisen/setting/account으로 넘어갈 수 있게
		// 만듦. 없으면 eisen/account로 주소창이 찍힘.
		model.addAttribute("pageParam", pageParam.isPresent() ? "setting/" + pageParam.get() : "setting");
		return "view/template/project";
	}

}
