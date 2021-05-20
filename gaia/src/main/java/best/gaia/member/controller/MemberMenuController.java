package best.gaia.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value = "view/member/")
public class MemberMenuController {
	private static final Logger logger = LoggerFactory.getLogger(MemberMenuController.class);
	// ajax에서만 불러옴. 주소창에 직접 작성하지 않는다.
	// 만약 주소창에 직접 작성한 경우??
	@RequestMapping(value = "{menuname}")
	public String menuMapper(
			@PathVariable String menuname
			,@RequestParam String mem_nick
			,Model model
			) {
		model.addAttribute("mem_nick", mem_nick);
		model.addAttribute("menuname", menuname);
		logger.info("{ menuname : }\n\n", menuname);
		return menuname;
	}
		
}