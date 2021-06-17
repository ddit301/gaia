package best.gaia.project.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
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
	
	@GetMapping
	public List<LabelVO> selectLabellist(
			HttpSession session
			) {
		
		int proj_no = getProjNoFromSession(session);
		
		return dao.selectLabelList(proj_no);
		
	}

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
	public LabelVO updateLabel(
			HttpSession session
			,@ModelAttribute LabelVO label) {
		int proj_no = getProjNoFromSession(session);
		label.setProj_no(proj_no);
		
		dao.updateLabel(label);
		
		return label;
	}

	@RequestMapping(method = RequestMethod.DELETE)
	public ServiceResult deleteLabel(
			@RequestParam int label_no
			) {
		
		ServiceResult result = service.deleteLabel(label_no);
		
		
		return result;
	}

}



