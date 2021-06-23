package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
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

import best.gaia.member.service.MemberService;
import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.CookieUtil;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;
import best.gaia.vo.ProjMemVO;
import best.gaia.vo.ProjectVO;

@RestController
@RequestMapping(value="restapi/project/members", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ProjectMemberRest {
	
	@Inject
	private ProjectService service;
	@Inject
	private MemberService memberService;
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
	
	/**
	 * project에 member 가입 시키는 메서드 
	 */
	@PostMapping
	public ServiceResult insertProjectMember(
			@ModelAttribute ProjMemVO projMem
			,HttpSession session
			,Authentication authentication) {
		int proj_no = getProjNoFromSession(session);
		projMem.setProj_no(proj_no);
		int mem_role_no = dao.selectLowestRoleNo(proj_no);
		projMem.setMem_role_no(mem_role_no);
		
		int result = dao.insertProjMem(projMem);
		
		// 프로젝트 생성자가 자동 가입 되는 경우가 아니면 해당 멤버에게 가입 되었다는 메시지를 보낸다.
		ProjectVO project = dao.selectProject(proj_no);
		int mem_no = projMem.getMem_no();
		if(project.getMem_no() != mem_no) {
			String proj_title = project.getProj_title();
			memberService.sendMessageToMemNo(
					mem_no, String.format("%s 프로젝트에 가입되었습니다.", proj_title));
		}
		
		return result == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@PutMapping
	public ServiceResult updateProjectMember(
			@ModelAttribute ProjMemVO projMem
			,HttpSession session
			,Authentication authentication
			,HttpServletResponse resp
			) {
		int proj_no = getProjNoFromSession(session);
		projMem.setProj_no(proj_no);
		
		// 회원 role 설정때는 mem_no가 파라미터로 오지만, 개인 프로젝트 닉네임 수정 할때는 파라미터가 없고, 인증 객체에서 받아옵니다.
		Boolean isNickChange = false;
		if(projMem.getMem_no() == null) {
			isNickChange = true;
			int mem_no = getMemberNoFromAuthentication(authentication);
			projMem.setMem_no(mem_no);
		}
		
		int result = dao.updateProjectMemberRole(projMem);
		
		// 닉네임 변경하는 업무였고, 성공 했으면 쿠키를 변경해준다.
		if(result == 1 && isNickChange == true) {
			CookieUtil.addCookie("proj_user_nick", projMem.getProj_user_nick(), resp);
		}
		
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
	
	@PutMapping("return")
	public ServiceResult returnProjectMember(
			@ModelAttribute ProjMemVO projMem
			,HttpSession session
			,Authentication authentication
			) {
		int proj_no = getProjNoFromSession(session);
		projMem.setProj_no(proj_no);
		int result = dao.setMemberActive(projMem);
		return result==1? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@GetMapping("search")
	public List<MemberVO> searchMemberToInvite(
			@RequestParam(required = false) String keyword
			,HttpSession session
			) {
		int proj_no = getProjNoFromSession(session);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("proj_no", proj_no);
		if(keyword != null) {
			paramMap.put("keyword", keyword);
		}
		return dao.searchMemberToInvite(paramMap);
	}
	
	
}






