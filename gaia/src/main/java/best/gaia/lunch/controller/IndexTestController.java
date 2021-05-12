package best.gaia.lunch.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.lunch.service.LunchService;
import oracle.jdbc.proxy.annotation.Methods;

@Controller
public class IndexTestController {
	
	@Inject
	private LunchService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping(value="/index", method = RequestMethod.GET)
	public String loginPage() {
		return "index";
	}
	
}
