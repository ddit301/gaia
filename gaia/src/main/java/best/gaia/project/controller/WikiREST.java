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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.service.ProjectService;
import best.gaia.utils.exception.NotValidSessionException;
import best.gaia.vo.WikiVO;

@RestController
@RequestMapping(value="restapi/project/wikis", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class WikiREST {
	
	@Inject
	private ProjectService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(WikiREST.class);
	
	@RequestMapping(method=RequestMethod.GET) 
	public List<WikiVO> selectwikiList(){
		
		return null;
	}
	@RequestMapping(value="{wiki_no}", method=RequestMethod.GET)
	public WikiVO selectWiki() {
		
		return null;
	}
	@RequestMapping(method=RequestMethod.POST) 
	public Map<String, Object> insertWiki(){
		
		return null;
	}
	@RequestMapping(method = RequestMethod.PUT)
	public Map<String, Object> updateWiki(){
		
		return null;
	}
	@RequestMapping(method = RequestMethod.DELETE)
	public Map<String, Object> deleteWiki() {
		
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
