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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.chat.dao.ElasticChatDao;
import best.gaia.chat.dao.ElasticChatDaoImpl;
import best.gaia.member.service.MemberService;
import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ProjectVO;

@RestController
@RequestMapping(value = "restapi/project/projects", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ProjectREST {

	@Inject
	private ProjectService service;
	@Inject
	private MemberService memberService;
	@Inject
	private ProjectDao dao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	@Inject
	private ElasticChatDao chatdao;
	

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
	// totalSearch
	@GetMapping(params = "{need=totalSearch}")
	public List<Map<String, Object>> selectKewordResult(
					Authentication authentication
					, @RequestParam String need
					, @RequestParam Map<String, Object> map
					) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		
		List<Map<String, Object>> result = chatdao.getTotalSearchResult((String) map.get("keyword")); 
		return result;
	}

	@PostMapping
	public ProjectVO insertProject(
			@ModelAttribute ProjectVO project
			,Authentication authentication
			) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		project.setMem_no(mem_no);
		
		service.insertProject(project);
		
		return project;
	}

	@PutMapping
	public ServiceResult updateProject(
			HttpSession session
			,@RequestParam Optional<String> proj_cont
			,@RequestParam Optional<String> proj_est_end_date
			,@RequestParam Optional<Integer> proj_module_set
			,@RequestParam Optional<Integer> issue_priority_set
			,@RequestParam Optional<String> proj_status
			) {
		int proj_no = getProjNoFromSession(session);
		ProjectVO original = dao.selectProject(proj_no);
		
		if(proj_cont.isPresent()) {
			original.setProj_cont(proj_cont.get());
		}else if(proj_est_end_date.isPresent()) {
			original.setProj_est_end_date(proj_est_end_date.get());
		}else if(proj_module_set.isPresent()) {
			original.setProj_module_set(proj_module_set.get());
		}else if(issue_priority_set.isPresent()) {
			original.setIssue_priority_set(issue_priority_set.get());
		}else if(proj_status.isPresent()) {
			original.setProj_status(proj_status.get());
			
			// project 종료시에는 해당 프로젝트 멤버들에게 문자를 보낸다.
			if("1".equals(proj_status.get())) {
				ProjectVO project = dao.selectProject(proj_no);
				String proj_title = project.getProj_title();
				String message = String.format("%s 프로젝트가 종료 되었습니다.", proj_title);
				if("ddit302".equals(proj_title)) {
					// ddit 302가 종료되는 경우 특별 메시지 전송
					message += " 지난 8개월 정말 고생 많으셨습니다.";
				}
				memberService.sendMessagesToProjMember(proj_no, message);
			}
		}
		
		return dao.updateProject(original) == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	
	@DeleteMapping
	public Map<String, Object> deleteProject() {
		return null;
	}
	
	@GetMapping("loadProjectOverview.do")
	public ProjectVO selectProjectOverview(HttpSession session) {
		int proj_no = getProjNoFromSession(session);
		return dao.selectProjectOverview(proj_no);
	}

}









