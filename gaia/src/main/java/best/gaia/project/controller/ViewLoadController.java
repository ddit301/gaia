package best.gaia.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "view/project")
public class ViewLoadController {
	
	@RequestMapping(value = "{menuname}")
	public String menuMapper(
			@PathVariable String menuname
			) {
		return "project/"+menuname;
	}
		
}
