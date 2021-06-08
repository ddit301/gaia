package best.gaia.project.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.MemberVO;
import best.gaia.vo.ProjectVO;

@RestController
@RequestMapping(value = "restapi/project/projects", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ProjectREST {

	@Inject
	private ProjectService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(ProjectREST.class);

	@RequestMapping(method = RequestMethod.GET)
	public List<ProjectVO> selectProjectList() {
		return null;
	}

	@RequestMapping(method = RequestMethod.POST)
	public Map<String, Object> insertProject() {
		return null;
	}

	@RequestMapping(method = RequestMethod.PUT)
	public Map<String, Object> updateProject() {
		return null;
	}

	@RequestMapping(method = RequestMethod.DELETE)
	public Map<String, Object> deleteProject() {
		return null;
	}

//	@RequestMapping(value="{issue_sid}", method=RequestMethod.GET)
//	public IssueVO selectIssue(
//				@PathVariable Integer issue_sid
//			) {
//		IssueVO search = new IssueVO();
//		search.setIssue_sid(issue_sid);
//		return service.selectIssue(search);
//	}

}
