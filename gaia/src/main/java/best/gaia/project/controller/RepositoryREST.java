package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.getProjNoFromSession;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.RepositoryDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;

@RestController
@RequestMapping(value = "restapi/project/repositories", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class RepositoryREST {

	@Inject
	private ProjectService service;
	@Inject
	private RepositoryDao dao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(RepositoryREST.class);

	@RequestMapping(method = RequestMethod.GET)
	public List<Map<String, Object>> selectRepositoryList(
			HttpSession session
			) {
		// session 에서 프로젝트 번호를 받아 오고
		int proj_no = getProjNoFromSession(session);
		
		// 해당 proj_no 에 속한 repository들 조회
		List<Map<String, Object>> repositories = dao.selectRepositoryList(proj_no);
		
		return repositories;
	}

	@RequestMapping(method = RequestMethod.POST)
	public ServiceResult insertRepository(
			HttpSession session
			,@RequestParam String repo_url
			,@RequestParam String repo_type
			) {
		Map<String,Object> repository = new HashMap<>();
		
		repository.put("repo_url", repo_url);
		repository.put("repo_type", repo_type);
		repository.put("proj_no", getProjNoFromSession(session));
		
		int result = dao.insertRepository(repository);
		
		return result == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@RequestMapping(method = RequestMethod.PUT)
	public Map<String, Object> updateRepository() {
		return null;
	}

	@RequestMapping(method = RequestMethod.DELETE)
	public ServiceResult deleteRepository(
			HttpSession session
			,@RequestParam String repo_type) {
		Map<String,Object> repository = new HashMap<>();
		
		repository.put("repo_type", repo_type);
		repository.put("proj_no", getProjNoFromSession(session));
		
		int result = dao.deleteRepository(repository);
		
		return result == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}








