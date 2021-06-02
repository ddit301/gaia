package best.gaia.issue.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class IssueViewController {
	
	@RequestMapping(value = "view/project/issueview")
	public String issueViewPage(
			@RequestParam Integer issue_no
			,Model model
			) {
		model.addAttribute("issue_no", issue_no);
		return "project/issueview";
	}
	
	@RequestMapping(value = "view/project/newissue")
	public String newIssuePage(
			) {
		return "project/newissue";
	}
		
}
