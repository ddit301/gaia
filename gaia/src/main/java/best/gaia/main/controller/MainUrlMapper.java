package best.gaia.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainUrlMapper {

	@GetMapping(value = "/intro")
	public String introPage() {
		return "redirect:/";
	}

	@GetMapping(value = "/demo")
	public String demoPage() {
		return "redirect:/";
	}

	@GetMapping(value = "/sales")
	public String salesPage() {
		return "redirect:/";
	}

	@GetMapping(value = "/updates")
	public String updatesPage() {
		return "redirect:/";
	}

	@GetMapping(value = "/signin")
	public String loginPage() {
		return "redirect:/";
	}

	@GetMapping(value = "/signup")
	public String logoutPage() {
		return "redirect:/";
	}

	@GetMapping(value = "/CS")
	public String CSPage() {
		return "redirect:/";
	}
	
}
