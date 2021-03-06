package best.gaia.issue.controller;

import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;


import best.gaia.issue.dao.IssueDao;
import best.gaia.issue.service.IssueService;
import best.gaia.utils.CookieUtil;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;
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
			,HttpServletRequest req
			,Authentication authentication
			,@ModelAttribute IssueVO issue
			,@ModelAttribute IssueHistoryVO issueHistory
			) {
		// history ????????? ?????? ????????? ?????? ??????
		issueHistory.setMem_no(getMemberNoFromAuthentication(authentication));
		
		// alarm ????????? ?????? ?????? ????????? ????????? ??????
		MemberVO historyWriter = new MemberVO();
		historyWriter.setMem_nick(CookieUtil.getCookie("proj_user_nick", req));
		issueHistory.setHistoryWriter(historyWriter);
		
		// issue ????????? ?????? ??????????????? ????????? ????????? ????????? ?????????.
		// ?????? ????????? ??? ????????? history ??? ?????? issue ??? ????????????.
		List<IssueHistoryVO> historyList = new ArrayList<>();
		historyList.add(issueHistory);
		issue.setHistoryList(historyList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("issueHistory", issueHistory);
		map.put("result", service.insertIssueHistory(issue));
		
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
