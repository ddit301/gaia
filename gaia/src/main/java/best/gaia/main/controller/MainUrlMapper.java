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
		return "redirect:/";
	}

	@RequestMapping(value = "/sales")
	public String salesPage() {
		return "redirect:/";
	}

	@RequestMapping(value = "/updates")
	public String updatesPage() {
		return "redirect:/";
	}

	@RequestMapping(value = "/signin")
	public String loginPage() {
		return "redirect:/";
	}

	@RequestMapping(value = "/signup")
	public String logoutPage() {
		return "redirect:/";
	}

	@RequestMapping(value = "/CS")
	public String CSPage() {
		return "redirect:/";
	}
	
}
