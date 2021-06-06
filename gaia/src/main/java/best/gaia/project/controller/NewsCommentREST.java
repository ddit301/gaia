package best.gaia.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.NewsDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.NewsCommentVO;

import static best.gaia.utils.SessionUtil.*;

@RestController
@RequestMapping(value="restapi/project/news-comments", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class NewsCommentREST {
	
	@Inject
	private ProjectService service;
	@Inject
	private NewsDao dao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(NewsCommentREST.class);
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertNewsComment(
		HttpSession session
		,Authentication authentication
		,@ModelAttribute NewsCommentVO newsComment
		) {
		
		if(authentication == null) {
			throw new UnauthorizedException();
		}
		
		int mem_no = getMemberNoFromAuthentication(authentication);
		newsComment.setMem_no(mem_no);
		
		// service 호출해 그 결과 result 에 담기
		ServiceResult result = 
				dao.insertNewsComment(newsComment) == 1 ? ServiceResult.OK : ServiceResult.FAIL;
		
		Map<String, Object> map = new HashMap<>();
		map.put("newsComment", newsComment);
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateNewsComment() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteNewsComment() {
		return null;
	}
	
	
	

}
