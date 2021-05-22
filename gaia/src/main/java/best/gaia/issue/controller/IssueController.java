package best.gaia.issue.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.issue.service.IssueService;
import best.gaia.vo.IssueVO;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/project/issue", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class IssueController {
	
	@Inject
	private IssueService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(IssueController.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public List<IssueVO> selectIssueList() {
		PagingVO<IssueVO> pagingVO = new PagingVO<IssueVO>();
		return service.selectIssueList(pagingVO);
	}
	
//	@RequestMapping(value="{issue_sid}", method=RequestMethod.GET)
//	public IssueVO selectIssue(
//				@PathVariable Integer issue_sid
//			) {
//		IssueVO search = new IssueVO();
//		search.setIssue_sid(issue_sid);
//		return service.selectIssue(search);
//	}
	
	
	

}
