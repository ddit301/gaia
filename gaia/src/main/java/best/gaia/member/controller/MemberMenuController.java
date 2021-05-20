package best.gaia.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value = "view/member/")
public class MemberMenuController {
	// ajax에서만 불러옴. 주소창에 직접 작성하지 않는다.
	// 만약 주소창에 직접 작성한 경우??
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