package best.gaia.issue.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class IssueViewController {
	
	@RequestMapping(value = "view/project/issueview")
	public String menuMapper(
			@RequestParam Integer issue_no
			,@RequestParam String manager_nick
			,@RequestParam String project_title
			,Model model
			) {
		model.addAttribute("issue_no", issue_no);
		model.addAttribute("manager_nick", manager_nick);
		model.addAttribute("project_title", project_title);
		return "project/issueview";
	}
		
}
