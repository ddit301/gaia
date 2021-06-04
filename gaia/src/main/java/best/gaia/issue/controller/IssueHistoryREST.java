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
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.issue.dao.IssueDao;
import best.gaia.issue.service.IssueService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.NotValidSessionException;
import best.gaia.utils.exception.UnauthorizedException;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.MemberVO;

@RestController
@RequestMapping(value="restapi/project/issue-history", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class IssueHistoryREST {
	
	@Inject
	private IssueService service;
	@Inject
	private IssueDao dao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(IssueHistoryREST.class);
	
	@GetMapping
	public List<IssueHistoryVO> selectIssueHistoryList(
			) {
		return null;
	}
	
	@PostMapping
	public Map<String, Object> insertIssueHistory(
			HttpSession session
			,Authentication authentication
			,@ModelAttribute IssueHistoryVO issueHistory
			) {
		if(authentication == null) {
			throw new UnauthorizedException();
		}
		MemberVO member = (MemberVO) authentication.getPrincipal();
		// 로그인 정보가 없을 경우 예외 처리
		if(member == null) {
			throw new NotValidSessionException();
		}
		issueHistory.setMem_no(member.getMem_no());
		
		// 해당 history를 insert 한다.
		ServiceResult result = dao.insertIssueHistory(issueHistory)==1? ServiceResult.OK : ServiceResult.FAIL;
		
		Map<String, Object> map = new HashMap<>();
		map.put("issueHistory", issueHistory);
		map.put("result", result);
		
		return map;
	}
	
	@PutMapping
	public Map<String, Object> updateIssueHistory() {
		return null;
	}
	
	@DeleteMapping
	public Map<String, Object> deleteIssueHistory() {
		return null;
	}
	
}
