package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.*;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.vo.IssueVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProjectVO;

@RestController
@RequestMapping(value = "restapi/project/projects", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ProjectREST {

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

	private static final Logger logger = LoggerFactory.getLogger(ProjectREST.class);

	@GetMapping
	public List<ProjectVO> selectProjectList(Authentication authentication) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		return dao.selectProjectList(mem_no);
	}

	@RequestMapping(method = RequestMethod.POST)
	public ProjectVO insertProject(
			@ModelAttribute ProjectVO project
			,Authentication authentication
			) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		project.setMem_no(mem_no);
		
		service.insertProject(project);
		
		return project;
	}

	@RequestMapping(method = RequestMethod.PUT)
	public Map<String, Object> updateProject() {
		return null;
	}

	@RequestMapping(method = RequestMethod.DELETE)
	public Map<String, Object> deleteProject() {
		return null;
	}

}
