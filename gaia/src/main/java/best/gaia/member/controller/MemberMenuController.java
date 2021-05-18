package best.gaia.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberMenuController {
	
	@RequestMapping(value = "view/member/overview")
	public String overview(
			) {
		return "member/overview";
	}
	@RequestMapping(value = "view/member/milestone")
	public String milestone(
			) {
		return "member/milestone";
	}
	@RequestMapping(value = "view/member/issue")
	public String issue(
			) {
		return "member/issue";
	}
		
}
