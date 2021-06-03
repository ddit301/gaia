package best.gaia.issue.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.function.Failable;
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
import best.gaia.utils.exception.NotValidSessionException;
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
		Integer proj_no = getProjNoFromSession(session);
		detailSearch.setProj_no(proj_no);
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
			) {
		MemberVO member = (MemberVO) authentication.getPrincipal();
		// 로그인 정보가 없을 경우 예외 처리
		if(member == null) {
			throw new NotValidSessionException();
		}
		issue.setMem_no(member.getMem_no());
		
		int proj_no = getProjNoFromSession(session);
		issue.setProj_no(proj_no);
		
		// issue에 issue_content를 history 형태로 담는다.
		List<IssueHistoryVO> histories = new ArrayList<>();
		IssueHistoryVO history = new IssueHistoryVO();
		history.setIssue_his_cont(issue_content);
		histories.add(history);
		issue.setHistoryList(histories);
		
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
	public Map<String, Object> updateIssue(
			@ModelAttribute IssueVO issue
		) {
		
		ServiceResult result = dao.updateIssue(issue) == 1 ? ServiceResult.OK : ServiceResult.FAIL;
		
		Map<String, Object> map = new HashMap<>();
		map.put("issue", issue);
		map.put("result", result);
		
		return map;
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
		
		Integer proj_no = getProjNoFromSession(session);
		
		Map<String, Object> map = new HashMap<>();
		map.put("proj_no", proj_no);
		map.put("issue_no", issue_no);
		
		IssueVO issue =  service.selectIssue(map);
		
		if(issue == null) {
			throw new ResourceNotFoundException();
		}
		
		return issue;
	}
	
	Integer getProjNoFromSession(HttpSession session){
		Integer proj_no = (Integer)session.getAttribute("proj_no");
		if(proj_no == null) {
			throw new NotValidSessionException();
		}
		return proj_no;
	}
	
	
	

}
