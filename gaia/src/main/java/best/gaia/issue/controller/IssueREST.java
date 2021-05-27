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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	
	@GetMapping
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
	
	@PostMapping
	public Map<String, Object> insertIssue() {
		return null;
	}
	
	@PutMapping
	public Map<String, Object> updateIssue() {
		return null;
	}
	
	@DeleteMapping
	public Map<String, Object> deleteIssue() {
		return null;
	}
	
	@GetMapping("{issue_no}")
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
