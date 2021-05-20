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

	
	@RequestMapping(value = "{manager_nick:^.*(?!admin)(?!view)(?!restapi)}/{project_title:^.*(?!new)(?!setting)(?!activity)}")
	public String projectTemplate(
			@PathVariable String manager_nick
			,@PathVariable String project_title
			,Model model
			) {
		model.addAttribute("manager_nick", manager_nick);
		model.addAttribute("project_title", project_title);
		model.addAttribute("projectMenu", "overview");
		return "project/project_template";
	}
	
	@RequestMapping(value = "{manager_nick:^.*(?!admin)(?!view)(?!restapi)}/{project_title:^.*(?!new)(?!setting)(?!activity)}/{projectmenu}")
	public String projectMenuOverview(
			@PathVariable String manager_nick,
			@PathVariable String project_title,
			@PathVariable String projectmenu
			,Model model
			) {
		model.addAttribute("manager_nick", manager_nick);
		model.addAttribute("project_title", project_title);
		model.addAttribute("projectMenu", projectmenu);
		return "project/project_template";
	}
	

}
