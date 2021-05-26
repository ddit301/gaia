package best.gaia.member.controller;

import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.service.ProjectService;

/**
 * 
 * @author Eisen
 * @since May 24, 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * May 24, 2021  Eisen    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 * admin,view,restapi 다중뎁스.나머지 0뎁
 */

@Controller
@RequestMapping(value = "{mem_nick:^(?:(?!admin$|restapi$|echo$|view$|intro$|demo$|sales$|updates$|signin$|signup$|CS$).)*}")
public class MemberTestController {
	
	@Inject
	private ProjectService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(MemberTestController.class);
	
	@RequestMapping(value = {"","{pageParam:^(?:(?=help$|overview$|setting-setting$|setting-new$|setting-activity$)).*}"})
	public String projectTemplate(
			@PathVariable String mem_nick
			, @PathVariable Optional<String> pageParam
			, Model model
			) {
		model.addAttribute("mem_nick", mem_nick);
		model.addAttribute("pageParam", pageParam.isPresent() ? pageParam.get() : null);
		return "view/template/member";
	}
}
