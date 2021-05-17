package best.gaia.project.controller;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.service.ProjectService;

@Controller
public class ProjectTestController {
	
	@Inject
	private ProjectService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectTestController.class);
	
	@RequestMapping(value = "project/overview")
	public String overview(
			) {
		return "project/overview";
	}
	@RequestMapping(value = "project/milestone")
	public String milestone(
			) {
		return "project/milestone";
	}
	@RequestMapping(value = "project/issue")
	public String issue(
			) {
		return "project/issue";
	}
	
	@RequestMapping(value = "{mem_nick}/setting")
	public String profileSetting(
			@PathVariable String mem_nick
			) {
		return "project/overview";
	}
	@RequestMapping(value = "{mem_nick}/activity")
	public String memberActivity(
			@PathVariable String mem_nick
			) {
		return "project/overview";
	}
	
	@RequestMapping(value = "{mem_nick}/{project_title:^.*(?!setting)(?!activity)}")
	public String projectTemplate(
			@PathVariable String mem_nick,
			@PathVariable String project_title
			,Model model
			) {
		model.addAttribute("mem_nick", mem_nick);
		model.addAttribute("project_title", project_title);
		return "project/project_template";
	}
	

}
