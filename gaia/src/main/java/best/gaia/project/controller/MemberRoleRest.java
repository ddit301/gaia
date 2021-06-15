package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.*;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;

@RestController
@RequestMapping(value="restapi/project/roles", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberRoleRest {
	
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
	
	private static final Logger logger = LoggerFactory.getLogger(MemberRoleRest.class);
	
	@GetMapping
	public List<Map<String, Object>> selectMemRoleList(
			HttpSession session
			) {
		int proj_no = getProjNoFromSession(session);
		return dao.selectMemRoleList(proj_no);
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertRole(
		HttpSession session
		,Authentication authentication
		) {
		
		return null;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateRole() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteRole() {
		return null;
	}
	
}
