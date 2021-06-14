package best.gaia.project.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.CookieUtil;
import best.gaia.utils.exception.ResourceNotFoundException;
import static best.gaia.utils.SessionUtil.*;
@Controller
@RequestMapping("{manager_id:^(?:(?!admin$|view$|restapi$).)*$}/{project_title:^(?:(?!overview$|help$|setting$).)*$}")
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
	
	@GetMapping({""
		,"{pageParam}"
		,"issue/{issue_no}"
		,"milestone/{milest_no}"
		})
	public String projectMenuOverview(
			@PathVariable String manager_id
			,@PathVariable String project_title
			,@PathVariable Optional<String> pageParam 
			,@PathVariable Optional<String> issue_no 
			,@PathVariable Optional<String> milest_no 
			,Authentication authentication
			,HttpSession session
			,Model model
			,HttpServletResponse resp
			) throws UnsupportedEncodingException {
		
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
		
		// pageParam 없는 요소들은 수동으로 pageParam 넣어주기. 
		// 매핑 패턴을 {pageParam}/{paramNo}하고 paramNo도 Optional로 받으면 하드코딩 하지 않아도 될듯.
		if(issue_no.isPresent()) {
			if("new".equals(issue_no.get())) {
				pageParam = Optional.of("issue/new");
			}else {
				pageParam = Optional.of("issueview");
			}
		}else if(milest_no.isPresent()) {
			if("new".equals(milest_no.get())) {
				pageParam = Optional.of("milestone/new");
			}else {
				pageParam = Optional.of("milestoneview");
			}
		}
		
		if(!pageParam.isPresent())
			pageParam = Optional.of("code");
		
		model.addAttribute("manager_id", manager_id);
		model.addAttribute("project_title", project_title);
		model.addAttribute("pageParam", pageParam.get());
		model.addAttribute("issue_no", issue_no.isPresent() ? issue_no.get() : null);
		model.addAttribute("milest_no", milest_no.isPresent() ? milest_no.get() : null);
		return "view/template/project";
	}
	
}
