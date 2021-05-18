package best.gaia.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProjectMenuController {
	
	@RequestMapping(value = "view/project/overview")
	public String overview(
			) {
		return "project/overview";
	}
	@RequestMapping(value = "view/project/milestone")
	public String milestone(
			) {
		return "project/milestone";
	}
	@RequestMapping(value = "view/project/issue")
	public String issue(
			) {
		return "project/issue";
	}
		
}
