package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.getProjNoFromSession;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ProjectVO;

@RestController
@RequestMapping(value = "restapi/project/")
public class ProjectController {
	
	@Inject
	private ProjectDao dao;
	
	@Inject
	private ProjectService service;
	
	@Inject
	private ProjectUrlMapper urlMapper;
	
	@GetMapping("loadProject.do")
	public ServiceResult menuMapper(
			@RequestParam String manager_id
			,@RequestParam String project_title
			,Authentication authentication
			,HttpSession session
			,HttpServletResponse resp
			,Model model
			) {
		urlMapper.loadProjectProcessor(manager_id, project_title, authentication, session, resp);
		return ServiceResult.OK;
	}
	
	@GetMapping("projTitleCheck.do")
	public ServiceResult projectNameValidator(
			@RequestParam String proj_title
			,Authentication authentication
			) {
		Boolean valid = service.isProjTitleValid(authentication, proj_title);
		return valid == true ? ServiceResult.OK : ServiceResult.FAIL;
		
	}
	
	@GetMapping("loadProjectForManagement.do")
	public ProjectVO loadProjectForManagement(
			HttpSession session
			) {
		int proj_no = getProjNoFromSession(session);
		return dao.loadProjectForManagement(proj_no);
	}
		
}










