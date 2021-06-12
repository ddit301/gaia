package best.gaia.main.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	@GetMapping("/signin")
	public String loginPage() {
		return "redirect:/";
	}
	@PostMapping("/signin")
	public String loginPageFail(
			Model model
			,HttpServletRequest req
			,RedirectAttributes redirect
			) {
		String message = req.getAttribute("message").toString();
		redirect.addFlashAttribute("message", message);
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
