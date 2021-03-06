package best.gaia.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
/**
 * 
 * @author Eisen
 * @since May 24, 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * May 24, 2021  Eisen    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 */
@Controller
@RequestMapping(value = "view/member/")
public class MemberViewLoadController {
	//.ajax로 page(html)을 return해 주는 메서드.
	private static final Logger logger = LoggerFactory.getLogger(MemberViewLoadController.class);
	@RequestMapping(value = {"{menuname}"})
	public String menuMapper(
			@PathVariable String menuname
			,@RequestParam String mem_id
			,Model model
			) {
		model.addAttribute("mem_id", mem_id);
		model.addAttribute("menuname", menuname);
		return "member/"+menuname;
	}
}