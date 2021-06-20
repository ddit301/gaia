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
	
	@RequestMapping(value = "{menuname}/{parameter}")
	public String menuMapperDeeper(
			@PathVariable String menuname
			,@PathVariable String parameter
			) {
		
		String viewPage = String.format("project/%s", menuname);
		
		return "new".equals(parameter) ? String.format("%s/new", viewPage) : String.format("%sview", viewPage);
	}
		
}
