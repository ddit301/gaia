package best.gaia.main.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.controller.LoginController;

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
	
	@RequestMapping(value = "/signup")
	public String logoutPage() {
		return "main/signup";
	}

	@RequestMapping(value = "/CS")
	public String CSPage() {
		return "main/CS";
	}
	
}