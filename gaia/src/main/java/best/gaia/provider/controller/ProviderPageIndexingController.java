package best.gaia.provider.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
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
@RequestMapping("admin")
public class ProviderPageIndexingController {

	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(ProviderPageIndexingController.class);

	@RequestMapping
	public String adminPage() {
		return "admin/index";
	}
	@RequestMapping(value = "member")
	public String memberListPage() {
		return "admin/member";
	}
	@RequestMapping(value = "inquiry")
	public String inquiryListPage() {
		return "admin/inquiry";
	}
	@RequestMapping(value = "finance")
	public String financePage() {
		return "admin/finance";
	}
	@RequestMapping(value = "statics")
	public String staticsPage() {
		return "admin/statics";
	}
	@RequestMapping(value = "monitoring")
	public String monitoringPage() {
		return "admin/monitoring";
	}

}
