package best.gaia.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProjectMenuController {
	
	@RequestMapping(value = "project/overview")
	public String overview(
			) {
		return "project/overview";
	}
	@RequestMapping(value = "project/milestone")
	public String milestone(
			) {
		return "project/milestone";
	}
	@RequestMapping(value = "project/issue")
	public String issue(
			) {
		return "project/issue";
	}
		
}
