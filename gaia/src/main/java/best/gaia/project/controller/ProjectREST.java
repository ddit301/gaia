package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
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
	public ServiceResult updateProject(
			HttpSession session
			,@RequestParam Optional<String> proj_cont
			,@RequestParam Optional<String> proj_est_end_date
			) {
		int proj_no = getProjNoFromSession(session);
		ProjectVO original = dao.selectProject(proj_no);
		
		if(proj_cont.isPresent()) {
			original.setProj_cont(proj_cont.get());
		}else if(proj_est_end_date.isPresent()) {
			original.setProj_est_end_date(proj_est_end_date.get());
		}
		
		
		return dao.updateProject(original) == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	
	@RequestMapping(method = RequestMethod.DELETE)
	public Map<String, Object> deleteProject() {
		return null;
	}

}
