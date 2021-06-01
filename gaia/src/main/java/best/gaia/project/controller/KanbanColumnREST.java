package best.gaia.project.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.KanbanDao;
import best.gaia.project.dao.NewsDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.exception.NotValidSessionException;
import best.gaia.vo.KanbanColumnVO;

@RestController
@RequestMapping(value="restapi/project/kanban-columns", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class KanbanColumnREST {
	
	@Inject
	private ProjectService service;
	@Inject
	private KanbanDao kanbanDao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(KanbanColumnREST.class);
	
	@GetMapping
	public List<KanbanColumnVO> selectKanbanColumnList(
			HttpSession session
			) {
		int proj_no = getProjNoFromSession(session);
		return kanbanDao.selectKanbanColumnList(proj_no);
	}
	
	@PostMapping
	public Map<String, Object> insertKanbanColumn() {
		return null;
	}
	
	@PutMapping
	public Map<String, Object> updateKanbanColumn() {
		return null;
	}
	
	@DeleteMapping
	public Map<String, Object> deleteKanbanColumn() {
		return null;
	}
	
	Integer getProjNoFromSession(HttpSession session){
		Integer proj_no = (Integer)session.getAttribute("proj_no");
		if(proj_no == null) {
			throw new NotValidSessionException();
		}
		return proj_no;
	}
	
	
	

}
