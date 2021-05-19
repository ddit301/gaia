package best.gaia.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "view/project/")
public class ProjectMenuController {
	
	@RequestMapping(value = "{menuname}")
	public String menuMapper(
			@PathVariable String menuname
			,@RequestParam String manager_nick
			,@RequestParam String project_title
			,Model model
			) {
		model.addAttribute("manager_nick", manager_nick);
		model.addAttribute("project_title", project_title);
		model.addAttribute("menuname", menuname);
		return "project/"+menuname;
	}
		
}
