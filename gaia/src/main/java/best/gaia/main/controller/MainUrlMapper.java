package best.gaia.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequestMapping
public class MainUrlMapper {

	@RequestMapping(value = "/intro")
	public String introPage() {
		return "redirect:/";
	}

	@RequestMapping(value = "/demo")
	public String demoPage() {
		return "redirect:/index.jsp";
	}

	@RequestMapping(value = "/sales")
	public String salesPage() {
		return "redirect:/index.jsp";
	}

	@RequestMapping(value = "/updates")
	public String updatesPage() {
		return "redirect:/index.jsp";
	}

	@RequestMapping(value = "/signin")
	public String loginPage() {
		return "redirect:/index.jsp";
	}

	@RequestMapping(value = "/signup")
	public String logoutPage() {
		return "redirect:/index.jsp";
	}

	@RequestMapping(value = "/CS")
	public String CSPage() {
		return "redirect:/index.jsp";
	}
	
}
