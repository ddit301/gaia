package best.gaia.member.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.service.MemberService;

@Controller
public class IndexTestController {
	
	@Inject
	private MemberService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping(value="/admin/index", method = RequestMethod.GET)
	public String loginPage() {
		return "admin/index";
	}
	
}
