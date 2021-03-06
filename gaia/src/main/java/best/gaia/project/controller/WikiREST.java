package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;
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
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.ResourceNotFoundException;
import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.PagingVO;
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
	public PagingVO<WikiVO> selectwikiList(
			HttpSession session
			, @RequestParam(required=false) String wiki_title
			,@ModelAttribute PagingVO<WikiVO> pagingVO
			){
		WikiVO detailSearch = new WikiVO();
		
		if(wiki_title != null) {
			detailSearch.setWiki_title(wiki_title);
		}
		
		detailSearch.setProj_no(getProjNoFromSession(session));
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setDataList(service.selectWikiList(pagingVO));
		
		return pagingVO;
	}
	@RequestMapping(value="{wiki_no}", method=RequestMethod.GET)
	public WikiVO selectWiki(
			@PathVariable Integer wiki_no
			, HttpSession session
			) {
		Integer proj_no = getProjNoFromSession(session);
		
		Map<String,Object>map = new HashMap<>();
		
		map.put("proj_no",proj_no);
		map.put("wiki_no", wiki_no);
		
		WikiVO wiki = service.selectWiki(map);
		
		if(wiki == null) {
			throw new ResourceNotFoundException();
		}

		return wiki;
	}
	@RequestMapping(value="history/{wiki_sid}" , method = RequestMethod.GET)
	public List<WikiVO> historyWiki(
				@PathVariable Integer wiki_sid
			) {
		PagingVO<WikiVO> pagingVO = new PagingVO<WikiVO>();
		WikiVO detailSearch = new WikiVO();
		
		detailSearch.setWiki_sid(wiki_sid);
		
		pagingVO.setDetailSearch(detailSearch);

		return service.historyWiki(pagingVO);
		
	}
	
	@RequestMapping(method=RequestMethod.POST) 
	public Map<String, Object> insertWiki(
			HttpSession session
			, Authentication authentication
			, @RequestParam (required = false) Integer parent_wiki
			, @ModelAttribute WikiVO wiki
			){
		
		if(authentication == null) {
			throw new UnauthorizedException();
		}
		
		wiki.setMem_no(getMemberNoFromAuthentication(authentication));
		wiki.setProj_no(getProjNoFromSession(session));
		wiki.setParent_wiki(parent_wiki);

		
		// service ????????? ??? ?????? result ??? ??????
				ServiceResult result = service.insertWiki(wiki);
				
				Map<String, Object> map = new HashMap<>();
				map.put("wiki", wiki);
				map.put("result", result);
				
				return map;
	}
	@RequestMapping(method = RequestMethod.PUT)
	public Map<String, Object> updateWiki(){
		
		return null;
	}
	@RequestMapping(method = RequestMethod.DELETE)
	public Map<String, Object> deleteWiki(
			@ModelAttribute WikiVO search
			, Authentication authentication
			) {
		
		ServiceResult result = service.deleteWiki(search);
		Map<String,Object>map = new HashMap<>();
		
		map.put("result", result);

		
		return map;
	}
	
	
}
