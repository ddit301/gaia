package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;
import static best.gaia.utils.SessionUtil.getProjNoFromSession;

import java.util.HashMap;
import java.util.Map;

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
import best.gaia.utils.CookieUtil;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.ResourceNotFoundException;
import best.gaia.vo.ProjectVO;

@RestController
@RequestMapping(value = "restapi/project/")
public class ProjectController {
	
	@Inject
	private ProjectDao dao;
	
	@Inject
	private ProjectService service;
	
	@GetMapping("loadProject.do")
	public ServiceResult menuMapper(
			@RequestParam String manager_id
			,@RequestParam String project_title
			,Authentication authentication
			,HttpSession session
			,HttpServletResponse resp
			,Model model
			) {
		// manager_id랑 project_title로 proj_no 찾아 내기
		Map<String, Object> map = new HashMap<>();
		map.put("manager_id", manager_id);
		map.put("project_title", project_title);
		Integer proj_no = dao.getProjNoFromIdAndTitle(map);
		
		// 존재하는 프로젝트 인지 검사 후 존재하지 않으면 404 에러 응답.
		if(proj_no == null)
			throw new ResourceNotFoundException();
		
		// 접속중인 유저가 해당 proj_no에 대해 조회할 수 있는 권한이 있는지 체크
		int mem_no = getMemberNoFromAuthentication(authentication);
		/* 코드 작성 필요*/
		
		// 조회중인 프로젝트의 proj_no 를 세션에 저장하기
		session.setAttribute("proj_no", proj_no);
		
		// Cookie 에 접속중인 회원의 proj 내에서의 닉네임을 쿠키에 저장하기
		String proj_user_nick = service.getProjectNick(proj_no, mem_no);
		CookieUtil.addCookie("proj_user_nick", proj_user_nick, resp);
		
		model.addAttribute("manager_id", manager_id);
		model.addAttribute("project_title", project_title);
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










