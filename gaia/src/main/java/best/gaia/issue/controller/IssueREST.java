package best.gaia.issue.controller;

import static best.gaia.utils.SessionUtil.*;

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
import org.apache.commons.lang.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import best.gaia.issue.dao.IssueDao;
import best.gaia.issue.dao.MilestoneDao;
import best.gaia.issue.service.IssueService;
import best.gaia.member.dao.MemberDao;
import best.gaia.project.dao.KanbanDao;
import best.gaia.project.dao.ProjectDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.ResourceNotFoundException;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProjMemVO;

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
			,@RequestParam Optional<String> searchKey
			,@RequestParam Optional<Integer> searchValue
			) {
		
		// session 에서 프로젝트 번호를 받아와 detailSearch에 등록합니다.
		detailSearch.setProj_no(getProjNoFromSession(session));
		
		// searchKey 와 searchValue가 있을 경우 detailSearch에 등록 합니다.
		if(searchKey.isPresent() && searchValue.isPresent()) {
			
			switch(searchKey.get()) {
			case "label_no": 
				detailSearch.setLabel_no(searchValue.get());
				break;
			case "writer_no":
				detailSearch.setMem_no(searchValue.get());
				break;
			case "priority":
				detailSearch.setIssue_priority(searchValue.get());
				break;
			case "milest_sid":
				detailSearch.setMilest_sid(searchValue.get());
				break;
			case "mem_no" :
				// 이슈 담당자 관련 프로퍼티가 없어서 progress를 빌린다.
				detailSearch.setProgress(searchValue.get());
				break;
			default:
				break;
			}
		}
		
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
		int proj_no = getProjNoFromSession(session);
		issue.setProj_no(proj_no);
		
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
				// column 정보와 previous 카드 정보 받아와서 입력
				int kb_col_no = kanbanDao.getFirstColumnNumber(proj_no);
				card.setKb_col_no(kb_col_no);
				Integer kb_card_priv_no = kanbanDao.getLastCardNo(kb_col_no);
				card.setKb_card_priv_no(kb_card_priv_no);
				kanbanDao.insertCard(card);
			}
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("issue_no", issue.getIssue_no());
		map.put("result", result);
		
		return map;
	}
	
	@PutMapping
	public IssueHistoryVO updateIssue(
			@RequestParam int issue_sid
			,@RequestParam String editpart
			,@RequestParam Optional<String> parameter
			,Authentication authentication
			,HttpSession session
		) {
		
		ServiceResult result = service.updateIssue(issue_sid, editpart, parameter);
		
		int mem_no = getMemberNoFromAuthentication(authentication);
		int proj_no = getProjNoFromSession(session);
		
		IssueHistoryVO history = new IssueHistoryVO();
		if(ServiceResult.OK.equals(result)) {
			// 해당하는 issue history를 남겨 준다.
			history.setIssue_sid(issue_sid);
			history.setMem_no(mem_no);
			String hisContent = parameter.isPresent()? getHistoryData(editpart,parameter.get(),proj_no) : null;
			history.setIssue_his_cont(hisContent);
			history.setIssue_his_type(getHistoryType(editpart,parameter));
			result = dao.insertIssueHistory(history) ==1 ? ServiceResult.OK : ServiceResult.FAIL;
		}
		
		return history;
	}
	
	
	// 이슈 히스토리 삽입할 데이터 DB에서 받아오는 메서드
	String getHistoryData(String editpart, String parameter, int proj_no) {
		String data = null;
		Integer intParameter = NumberUtils.isNumber(parameter)? Integer.parseInt(parameter) : null;
		
		// 중간에 data= 없는 부분들은 아래까지 중첩이라 비워둔 겁니다.
		switch(editpart) {
		case "milest_sid": 
			data = dao.selectMilestoneTitle(intParameter); 
			break;
		case "assigneeAdd":
		case "assigneeDel": 
			ProjMemVO projMem = new ProjMemVO();
			projMem.setMem_no(intParameter);
			projMem.setProj_no(proj_no);
			data =dao.selectMemProjNick(projMem);
			break;
		case "label_no": 
			data = dao.selectLabelName(intParameter); 
			break;
		case "issue_priority": 
		case "issue_start_date":
		case "issue_end_date": 
		case "issue_title": 
		default:
			data = parameter; 
			break;
		}
		
		return data;
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
	
	/**
	 * 여러개의 이슈를 한번에 닫는 컨트롤러
	 * @param closingIssueNumbers
	 * @return
	 */
	@PutMapping("closeManyIssues.do")
	public ServiceResult closeManyIssues(
			@RequestParam String closingIssueNumbers
			,Authentication authentication
			) {
		
		int mem_no = getMemberNoFromAuthentication(authentication);
		List<Integer> issueSids = new Gson().fromJson(closingIssueNumbers, new TypeToken<ArrayList<Integer>>(){}.getType());
		
		return service.closeManyIssues(issueSids,mem_no);
		
	}
	
	

}









