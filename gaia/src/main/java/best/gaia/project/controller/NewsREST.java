package best.gaia.project.controller;
import static best.gaia.utils.SessionUtil.*;
import static best.gaia.utils.SessionUtil.*;

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

import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/project/news", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class NewsREST {
	
	@Inject
	private ProjectService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(NewsREST.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public PagingVO<NewsVO> selectNewsList(
			HttpSession session
			,@ModelAttribute PagingVO<NewsVO> pagingVO
			) {
		NewsVO detailSearch = new NewsVO();
		
		detailSearch.setProj_no(getProjNoFromSession(session));
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setDataList(service.selectNewsList(pagingVO));
		
		return pagingVO;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertNews(
		HttpSession session
		,Authentication authentication
		,@ModelAttribute NewsVO news
		) {
		
		news.setMem_no(getMemberNoFromAuthentication(authentication));
		news.setProj_no(getProjNoFromSession(session));
		
		// service 호출해 그 결과 result 에 담기
		ServiceResult result = service.insertNews(news);
		
		Map<String, Object> map = new HashMap<>();
		map.put("news", news);
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateNews() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteNews() {
		return null;
	}
	
//	@RequestMapping(value="{news_no}", method=RequestMethod.GET)
//	public IssueVO selectIssue(
//				@PathVariable Integer issue_sid
//			) {
//		IssueVO search = new IssueVO();
//		search.setIssue_sid(issue_sid);
//		return service.selectIssue(search);
//	}
	
	

}
