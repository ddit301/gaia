package best.gaia.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "view/project/")
public class ProjectMenuController {
	
	@RequestMapping(value = "overview")
	public String overview(
			) {
		return "project/overview";
	}
	@RequestMapping(value = "milestone")
	public String milestone(
			) {
		return "project/milestone";
	}
	@RequestMapping(value = "issue")
	public String issue(
			) {
		return "project/issue";
	}
		
}
