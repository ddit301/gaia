package best.gaia.issue.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.issue.service.IssueService;
import best.gaia.project.dao.ProjectDao;
import best.gaia.vo.IssueVO;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/project/issues", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class IssueREST {
	
	@Inject
	private IssueService service;
	@Inject
	private ProjectDao projDao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(IssueREST.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public List<IssueVO> selectIssueList() {
		PagingVO<IssueVO> pagingVO = new PagingVO<IssueVO>();
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
				,@RequestParam String manager_nick
				,@RequestParam String project_title
			) {
		IssueVO search = new IssueVO();
		
		Map<String, Object> map = new HashMap<>();
		map.put("mem_nick", manager_nick);
		map.put("proj_title", project_title);
		map.put("issue_no", issue_no);
		
		return service.selectIssue(map);
	}
	
	
	

}
