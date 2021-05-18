package best.gaia.member.controller;

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
@RequestMapping(value = "{mem_nick:^.*(?!intro)(?!demo)(?!sales)(?!updates)(?!signin)(?!signup)(?!CS)(?!view)}")
public class ProfileTestController {
	
	@Inject
	private ProjectService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(ProfileTestController.class);
	
	@RequestMapping(value = {"", "/overview"})
	public String memberMain(
			@PathVariable String mem_nick
			,Model model
			) {
		model.addAttribute("mem_nick", mem_nick);
		model.addAttribute("mem_menu", "overview");
		return "member/member_template";
	}
	
	@RequestMapping(value = "/setting")
	public String profileSetting(
			@PathVariable String mem_nick
			,Model model
			) {
		model.addAttribute("mem_menu", "setting");
		return "member/member_template";
	}
	
	@RequestMapping(value = "/activity")
	public String memberActivity(
			@PathVariable String mem_nick
			,Model model
			) {
		model.addAttribute("mem_menu", "activity");
		return "member/member_template";
	}
	
	@RequestMapping(value = "/new")
	public String projectNew(
			@PathVariable String mem_nick
			,Model model
			) {
		model.addAttribute("mem_nick", mem_nick);
		model.addAttribute("mem_menu", "setting");
		return "member/member_template";
	}
	@RequestMapping(value = "/help")
	public String help(
			@PathVariable String mem_nick
			,Model model
			) {
		model.addAttribute("mem_nick", mem_nick);
		model.addAttribute("mem_menu", "help");
		return "member/member_template";
	}
}
