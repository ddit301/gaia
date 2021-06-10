package best.gaia.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WikiViewController {
	
	@RequestMapping(value = "view/project/wikiView")
	public String menuMapper(
			@RequestParam Integer wiki_no
			,@RequestParam String manager_id
			,@RequestParam String project_title
			,Model model
			) {
		model.addAttribute("wiki_no", wiki_no);
		model.addAttribute("manager_id", manager_id);
		model.addAttribute("project_title", project_title);
		return "project/wiki";
	}
		
}
