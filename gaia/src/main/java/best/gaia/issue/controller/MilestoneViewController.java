package best.gaia.issue.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MilestoneViewController {
	
	@RequestMapping(value = "view/project/milestoneview")
	public String menuMapper(
			@RequestParam Integer milest_no
			,@RequestParam String manager_id
			,@RequestParam String project_title
			,Model model
			) {
		model.addAttribute("milest_no", milest_no);
		model.addAttribute("manager_id", manager_id);
		model.addAttribute("project_title", project_title);
		return "project/milestoneview";
	}
		
}
