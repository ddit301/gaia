package best.gaia.issue.controller;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.issue.service.IssueService;
import best.gaia.utils.exception.ResourceNotFoundException;
import best.gaia.vo.IssueVO;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/project/issues", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class IssueREST {
	
	@Inject
	private IssueService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(IssueREST.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public List<IssueVO> selectIssueList(
			HttpSession session
			) {
		
		PagingVO<IssueVO> pagingVO = new PagingVO<IssueVO>();
		IssueVO detailSearch = new IssueVO();
		
		// 조회할 issue에 대한 필터를 parameter에서 받아와 등록합니다.
		
		// session 에서 프로젝트 번호를 받아와 detailSearch에 등록합니다.
		detailSearch.setProj_no((Integer)session.getAttribute("proj_no"));
		
		pagingVO.setDetailSearch(detailSearch);
		
		return service.selectIssueList(pagingVO);
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertIssue() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateIssue() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteIssue() {
		return null;
	}
	
	@RequestMapping(value="{issue_no}", method=RequestMethod.GET)
	public IssueVO selectIssue(
				@PathVariable Integer issue_no
				,HttpSession session
			) {
		
		int proj_no = (Integer)session.getAttribute("proj_no");
		
		Map<String, Object> map = new HashMap<>();
		map.put("proj_no", proj_no);
		map.put("issue_no", issue_no);
		
		IssueVO issue =  service.selectIssue(map);
		
		if(issue == null) {
			throw new ResourceNotFoundException();
		}
		
		return issue;
	}
	
	
	

}
