package best.gaia.main.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

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
@RequestMapping("view")
public class MainPageIndexingController {

	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(MainPageIndexingController.class);

	@GetMapping(value = "/intro")
	public String introPage() {
		return "main/intro";
	}

	@GetMapping(value = "/demo")
	public String demoPage() {
		return "main/demo";
	}

	@GetMapping(value = "/sales")
	public String salesPage() {
		return "main/sales";
	}

	@GetMapping(value = "/updates")
	public String updatesPage() {
		return "main/updates";
	}

	@GetMapping(value = "/signin")
	public String loginPage() {
		return "main/signin";
	}

	@GetMapping(value = "/signup")
	public String logoutPage() {
		return "main/signup";
	}

	@GetMapping(value = "/CS")
	public String CSPage() {
		return "main/CS";
	}

}
