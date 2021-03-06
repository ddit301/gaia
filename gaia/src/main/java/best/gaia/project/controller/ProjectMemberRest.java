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

import best.gaia.alarm.service.AlarmService;
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
	private AlarmService alarmService;
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
	 * project??? member ?????? ????????? ????????? 
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
		
		// ???????????? ???????????? ?????? ?????? ?????? ????????? ????????? ?????? ???????????? ?????? ???????????? ???????????? ?????????.
		ProjectVO project = dao.selectProject(proj_no);
		int mem_no = projMem.getMem_no();
		if(project.getMem_no() != mem_no) {
			String proj_title = project.getProj_title();
			memberService.sendMessageToMemNo(
					mem_no, String.format("%s ??????????????? ?????????????????????.", proj_title));
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
		
		// ?????? role ???????????? mem_no??? ??????????????? ?????????, ?????? ???????????? ????????? ?????? ????????? ??????????????? ??????, ?????? ???????????? ???????????????.
		Boolean isNickChange = false;
		if(projMem.getMem_no() == null) {
			isNickChange = true;
			int mem_no = getMemberNoFromAuthentication(authentication);
			projMem.setMem_no(mem_no);
		}
		
		int result = dao.updateProjectMemberRole(projMem);
		
		// ????????? ???????????? ????????????, ?????? ????????? ????????? ???????????????.
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
		
		// ????????? ?????? ???????????? ?????? ???????????? ????????? ????????????.
		if(result == 1) {
			ProjectVO project = dao.selectProject(proj_no);
			Map<String, Object> inviteInfo = new HashMap<>();
			inviteInfo.put("proj_title", project.getProj_title());
			inviteInfo.put("ownerNo", project.getMem_no());
			inviteInfo.put("receiverNo", projMem.getMem_no());
			return alarmService.insertInviteAlarm(inviteInfo);
		}
		
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






