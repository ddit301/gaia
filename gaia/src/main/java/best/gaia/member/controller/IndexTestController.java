package best.gaia.member.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

@Controller
public class IndexTestController {

	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
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
	@RequestMapping(value = "/CS")
	public String CSPage() {
		return "main/CS";
	}

//	@RequestMapping(value = "/index", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	public void loginPage(@RequestParam String anchor, Model model) {
//
//		model.addAttribute("view",anchor);
//	}

}
