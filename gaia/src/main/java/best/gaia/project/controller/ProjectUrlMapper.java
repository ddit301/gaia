package best.gaia.project.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.exception.ResourceNotFoundException;
@Controller
@RequestMapping("{manager_nick:^(?:(?!admin$|resources$|view$|restapi$).)*$}/{project_title:^(?:(?!new$|overview$|help$|setting$|activity$).)*$}")
public class ProjectUrlMapper {
	
	@Inject
	private ProjectService service;
	@Inject
	private ProjectDao dao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectUrlMapper.class);

	
	@RequestMapping(value = {"","{pageParam}"})
	public String projectMenuOverview(
			@PathVariable String manager_nick
			,@PathVariable String project_title
			,@PathVariable Optional<String> pageParam 
			,HttpSession session
			,Model model
			) {
		
		// manager_nick 이랑 project_title로 proj_no 찾아 내기
		Map<String, Object> map = new HashMap<>();
		map.put("manager_nick", manager_nick);
		map.put("project_title", project_title);
		Integer proj_no = dao.getProjNoWithMngNickkAndPrjTitle(map);
		
		// 존재하는 프로젝트 인지 검사 후 존재하지 않으면 404 에러 응답.
		if(proj_no == null) {
			throw new ResourceNotFoundException();
		}
		
		// 접속중인 유저가 해당 proj_no에 대해 조회할 수 있는 권한이 있는지 체크
		
		// 조회중인 프로젝트의 proj_no 를 세션에 저장하기
		session.setAttribute("proj_no", proj_no);
		
		model.addAttribute("manager_nick", manager_nick);
		model.addAttribute("project_title", project_title);
		model.addAttribute("pageParam", pageParam.isPresent() ? pageParam.get() : null );
		return "view/template/project";
	}
	
	@RequestMapping(value = "issue/{issue_no}")
	public String IssueViewer(
			@PathVariable String manager_nick
			,@PathVariable String project_title
			,@PathVariable Integer issue_no
			,Model model
			) {
		model.addAttribute("issue_no", issue_no);
		model.addAttribute("manager_nick", manager_nick);
		model.addAttribute("project_title", project_title);
		return "view/template/project";
	}
	

}
