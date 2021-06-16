package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.getProjNoFromSession;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.vo.LabelVO;

@RestController
@RequestMapping(value = "restapi/project/labels", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class LabelREST {

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

	private static final Logger logger = LoggerFactory.getLogger(LabelREST.class);

	@RequestMapping(method = RequestMethod.POST)
	public LabelVO insertLabel(
			HttpSession session
			,@ModelAttribute LabelVO label
			) {
		
		int proj_no = getProjNoFromSession(session);
		label.setProj_no(proj_no);
		
		int result = dao.insertLabel(label);
		
		return result==1? label : null;
	}

	@RequestMapping(method = RequestMethod.PUT)
	public Map<String, Object> updateLabel() {
		return null;
	}

	@RequestMapping(method = RequestMethod.DELETE)
	public Map<String, Object> deleteLabel() {
		return null;
	}

}
