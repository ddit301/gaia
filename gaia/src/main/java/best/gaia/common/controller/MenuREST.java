package best.gaia.common.controller;

import static best.gaia.utils.SessionUtil.getProjNoFromSession;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.common.dao.CommonCodeDao;
import best.gaia.common.service.CommonCodeService;
import best.gaia.project.dao.RepositoryDao;
import best.gaia.project.service.ProjectService;
import best.gaia.vo.ProjectVO;

@RestController
@RequestMapping(value = "restapi/project/menu", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MenuREST {

	@Inject
	private CommonCodeDao dao;
	
	@Inject
	private CommonCodeService service;
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(MenuREST.class);

	@GetMapping
	public List<Map<String, Object>> selectMenuList(
			HttpSession session
			) {
		int proj_no = getProjNoFromSession(session);
		
		// 프로젝트에 속하지 않은 메뉴는 service 로직에서 미리 걸러서 보내준다.
		
		return service.selectMenuList(proj_no);
	}


}
