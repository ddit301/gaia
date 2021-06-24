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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.issue.service.IssueService;
import static best.gaia.utils.SessionUtil.*;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.ResourceNotFoundException;
import best.gaia.vo.MilestoneVO;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/project/milestones", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MilestoneREST {
	
	@Inject
	private IssueService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(MilestoneREST.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public List<MilestoneVO> selectMilestoneList(
				HttpSession session
				, @RequestParam(required=false) String milest_status
			) {
		
		PagingVO<MilestoneVO> pagingVO = new PagingVO<MilestoneVO>();
		MilestoneVO detailSearch = new MilestoneVO();
		
		Integer proj_no = getProjNoFromSession(session);
		
		detailSearch.setProj_no(proj_no);
		detailSearch.setMilest_status(milest_status);
		
		pagingVO.setDetailSearch(detailSearch);
		
		return service.selectMilestoneList(pagingVO);
	}
	@RequestMapping(value="{milest_no}", method=RequestMethod.GET)
	public MilestoneVO selectMilestone(
				@PathVariable Integer milest_no
				, @RequestParam(required=false) Integer issue_status
				,HttpSession session
			) {
		
		Integer proj_no = getProjNoFromSession(session);
		
		
		Map<String,Object>map = new HashMap<>();
		
		map.put("proj_no", proj_no);
		map.put("milest_no",milest_no);
		
		if(issue_status != null) {
			map.put("issue_status",issue_status);			
		}
		
		MilestoneVO milestone = service.selectMilestone(map);
		
		if(milestone == null) {
			throw new ResourceNotFoundException();
		}
		
		return milestone;
	}
	@RequestMapping(method=RequestMethod.GET, params = "need")
	public Map<String, Object> selectMilestoneIssueList(
				@RequestParam String need
				, @RequestParam(required=false) Integer issue_status
				,HttpSession session
			) {
		Integer proj_no = getProjNoFromSession(session);
		
		List<MilestoneVO> list = service.selectMilestoneList(proj_no);
		
		Map<String,Object> result = new HashMap<>();
		result.put("list", list);
		return result;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertMilestone(
				HttpSession session
				, @ModelAttribute MilestoneVO milestone
				, Authentication authentication
			) {
		
		// memberVO 가 가지고 있는 mem_no milestone에 넣기 
		milestone.setMem_no(getMemberNoFromAuthentication(authentication));
		
		// proj_no 를 milestone VO 에 넣기 
		int proj_no = getProjNoFromSession(session);
		milestone.setProj_no(proj_no);
		
		ServiceResult result = service.insertMilestone(milestone);
		
		Map<String, Object> map = new HashMap<>();
		map.put("milest_no",milestone.getMilest_no());
		map.put("result",result);

		return map;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateMilestone(
				 @ModelAttribute MilestoneVO milestone
				, Authentication authentication
			) {
		
		// memberVO 가 가지고 있는 mem_no milestone에 넣기 
		milestone.setMem_no(getMemberNoFromAuthentication(authentication));
		
		ServiceResult result = service.updateMilestone(milestone);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("result",result);

		return map;
	}
	
	@DeleteMapping()
	public Map<String, Object> deleteMilestone(
				 @ModelAttribute MilestoneVO search
				 , Authentication authentication
			) {
		
		ServiceResult result = service.deleteMilestone(search);
		Map<String,Object>map = new HashMap<>();
		
		map.put("result",result);
		
		return map;
		
	}
	
	
}
