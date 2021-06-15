package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.*;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ProjMemVO;

@RestController
@RequestMapping(value="restapi/project/members", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ProjectMemberRest {
	
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
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectMemberRest.class);
	
	@GetMapping
	public List<ProjMemVO> loadProjectMembers(
			HttpSession session
			,@RequestParam(required = false) String searchword
			){
		int proj_no = getProjNoFromSession(session);
		return service.selectProjectMembers(proj_no, searchword);
	}
	
	@PostMapping
	public Map<String, Object> insertProjectMember(
		HttpSession session
		,Authentication authentication
		) {
		
		return null;
	}
	
	@PutMapping
	public ServiceResult updateProjectMember(
			@ModelAttribute ProjMemVO projMem
			,HttpSession session
			,Authentication authentication
			) {
		int proj_no = getProjNoFromSession(session);
		projMem.setProj_no(proj_no);
		
		int result = dao.updateProjectMemberRole(projMem);
		return result==1? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@DeleteMapping
	public ServiceResult deleteProjectMember(
			@ModelAttribute ProjMemVO projMem
			,HttpSession session
			,Authentication authentication
			) {
		int proj_no = getProjNoFromSession(session);
		projMem.setProj_no(proj_no);
		int result = dao.setMemberInactive(projMem);
		return result==1? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	
}






