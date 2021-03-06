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
		
		// session ?????? ???????????? ????????? ????????? detailSearch??? ???????????????.
		detailSearch.setProj_no(getProjNoFromSession(session));
		
		// searchKey ??? searchValue??? ?????? ?????? detailSearch??? ?????? ?????????.
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
				// ?????? ????????? ?????? ??????????????? ????????? progress??? ?????????.
				detailSearch.setProgress(searchValue.get());
				break;
			default:
				break;
			}
		}
		
		pagingVO.setDetailSearch(detailSearch);
		
		// issueList ??? ????????? pagingVO ??? ?????????.
		List<IssueVO> issueList = service.selectIssueList(pagingVO);
		pagingVO.setDataList(issueList);
		
		// pagingVO ????????? ?????? ????????????.
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
		
		// ?????? ???????????? ????????? ?????? ???????????? issue ????????? ?????????.
		if(assigneeMemNos.isPresent() && StringUtils.isNotBlank(assigneeMemNos.get())) {
			String[] memNumbers = assigneeMemNos.get().split(",");
			Set<MemberVO> assigneeList = new HashSet<>();
			for(String mem_no : memNumbers) {
				MemberVO assignee = new MemberVO(Integer.parseInt(mem_no));
				assigneeList.add(assignee);
			}
			issue.setAssigneeList(assigneeList);
		}
		
		// issue??? issue_content??? history ????????? ?????????.
		List<IssueHistoryVO> histories = new ArrayList<>();
		IssueHistoryVO history = new IssueHistoryVO();
		history.setIssue_his_cont(issue_content);
		histories.add(history);
		issue.setHistoryList(histories);
		
		// ????????? issue??? insert Issue ????????? ?????????.
		ServiceResult result = service.insertIssue(issue);
		
		// ????????? ?????? ??????????????? ???????????? ????????? ?????? ????????? ????????? ???????????????.
		if(result == ServiceResult.OK) {
			if(addToKanban) {
				KanbanCardVO card = new KanbanCardVO();
				card.setIssue_sid(issue.getIssue_sid());
				card.setMem_no(issue.getMem_no());
				// column ????????? previous ?????? ?????? ???????????? ??????
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
			// ???????????? issue history??? ?????? ??????.
			history.setIssue_sid(issue_sid);
			history.setMem_no(mem_no);
			String hisContent = parameter.isPresent()? getHistoryData(editpart,parameter.get(),proj_no) : null;
			history.setIssue_his_cont(hisContent);
			history.setIssue_his_type(getHistoryType(editpart,parameter));
			result = dao.insertIssueHistory(history) ==1 ? ServiceResult.OK : ServiceResult.FAIL;
		}
		
		return history;
	}
	
	
	// ?????? ???????????? ????????? ????????? DB?????? ???????????? ?????????
	String getHistoryData(String editpart, String parameter, int proj_no) {
		String data = null;
		Integer intParameter = NumberUtils.isNumber(parameter)? Integer.parseInt(parameter) : null;
		
		// ????????? data= ?????? ???????????? ???????????? ???????????? ????????? ?????????.
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
	 * ???????????? ????????? ????????? ?????? ????????????
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









