package best.gaia.issue.controller;

import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;
import static best.gaia.utils.SessionUtil.getProjNoFromSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.issue.dao.IssueDao;
import best.gaia.issue.service.IssueService;
import best.gaia.project.dao.KanbanDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.ResourceNotFoundException;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/project/issues", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class IssueREST {
	
	@Inject
	private IssueService service;
	@Inject
	private IssueDao dao;
	@Inject
	private KanbanDao kanbanDao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(IssueREST.class);
	
	@GetMapping
	public PagingVO<IssueVO> selectIssueList(
			HttpSession session
			,@ModelAttribute PagingVO<IssueVO> pagingVO
			,@ModelAttribute IssueVO detailSearch
			) {
		// session 에서 프로젝트 번호를 받아와 detailSearch에 등록합니다.
		detailSearch.setProj_no(getProjNoFromSession(session));
		pagingVO.setDetailSearch(detailSearch);
		
		// issueList 를 받아와 pagingVO 에 담는다.
		List<IssueVO> issueList = service.selectIssueList(pagingVO);
		pagingVO.setDataList(issueList);
		
		// pagingVO 형태로 값을 반환한다.
		return pagingVO;
	}
	
	@PostMapping
	public Map<String, Object> insertIssue(
			HttpSession session
			,Authentication authentication
			,@ModelAttribute IssueVO issue
			,@RequestParam String issue_content
			,@RequestParam Boolean addToKanban
			,@RequestParam Optional<String> assigneeMemNos
			) {
		issue.setMem_no(getMemberNoFromAuthentication(authentication));
		issue.setProj_no(getProjNoFromSession(session));
		
		// 이슈 담당자들 존재할 경우 처리해서 issue 객체에 담는다.
		if(assigneeMemNos.isPresent() && StringUtils.isNotBlank(assigneeMemNos.get())) {
			String[] memNumbers = assigneeMemNos.get().split(",");
			Set<MemberVO> assigneeList = new HashSet<>();
			for(String mem_no : memNumbers) {
				MemberVO assignee = new MemberVO(Integer.parseInt(mem_no));
				assigneeList.add(assignee);
			}
			issue.setAssigneeList(assigneeList);
		}
		
		// issue에 issue_content를 history 형태로 담는다.
		List<IssueHistoryVO> histories = new ArrayList<>();
		IssueHistoryVO history = new IssueHistoryVO();
		history.setIssue_his_cont(issue_content);
		histories.add(history);
		issue.setHistoryList(histories);
		
		// 준비된 issue를 insert Issue 로직에 태운다.
		ServiceResult result = service.insertIssue(issue);
		
		// 칸반에 바로 추가하도록 설정되어 있으면 이슈 등록후 카드도 추가해준다.
		if(result == ServiceResult.OK) {
			if(addToKanban) {
				KanbanCardVO card = new KanbanCardVO();
				card.setIssue_sid(issue.getIssue_sid());
				card.setMem_no(issue.getMem_no());
				kanbanDao.insertCardWithIssue(card);
			}
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("issue_no", issue.getIssue_no());
		map.put("result", result);
		
		return map;
	}
	
	@PutMapping
	public ServiceResult updateIssue(
			@RequestParam int issue_sid
			,@RequestParam String editpart
			,@RequestParam Optional<String> parameter
		) {
		
		ServiceResult result = service.updateIssue(issue_sid, editpart, parameter);
		
		return result;
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
		
		Map<String, Object> map = new HashMap<>();
		map.put("proj_no", getProjNoFromSession(session));
		map.put("issue_no", issue_no);
		
		IssueVO issue =  service.selectIssue(map);
		
		if(issue == null) {
			throw new ResourceNotFoundException();
		}
		
		return issue;
	}
	
	

}
