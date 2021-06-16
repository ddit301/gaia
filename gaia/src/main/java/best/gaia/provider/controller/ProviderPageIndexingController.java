package best.gaia.provider.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.main.controller.MainPageIndexingController;

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

//	@GetMapping(value = { "{menuname:^(?:(?=|\\/|member$|inquiry$|finance$|statics$|monitoring$)).*}" })
	@GetMapping(value = { "{menuname:^(?:(?=member$|inquiry$|finance$|statics$|monitoring$)).*}" })
	public String page(@PathVariable String menuname) {
		if (menuname.length() <= 1)
			menuname = "index";
		return "admin/" + menuname;
	}

	@RequestMapping
	public String adminPage() {
		return "admin/index";
	}

}
