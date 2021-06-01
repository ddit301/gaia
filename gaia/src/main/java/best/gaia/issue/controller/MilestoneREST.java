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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.issue.service.IssueService;
import best.gaia.utils.exception.NotValidSessionException;
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
			) {
		
		PagingVO<MilestoneVO> pagingVO = new PagingVO<MilestoneVO>();
		MilestoneVO detailSearch = new MilestoneVO();
		
		Integer proj_no = getProjNoFromSession(session);
		
		detailSearch.setProj_no(proj_no);
		
		pagingVO.setDetailSearch(detailSearch);
		
		return service.selecMilestoneList(pagingVO);
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertMilestone() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateMilestone() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteMilestone() {
		return null;
	}
	@RequestMapping(value="{milest_no}", method=RequestMethod.GET)
	public MilestoneVO selectMilestone(
				@PathVariable Integer milest_no
				,HttpSession session
			) {
		
		Integer proj_no = getProjNoFromSession(session);
		
		
		Map<String,Object>map = new HashMap<>();
		
		map.put("proj_no", proj_no);
		map.put("milest_no",milest_no);
		
		MilestoneVO milestone = service.selectMilestone(map);
		
		if(milestone == null) {
			throw new ResourceNotFoundException();
		}
		
		return milestone;
	}
	
	Integer getProjNoFromSession(HttpSession session){
		Integer proj_no = (Integer)session.getAttribute("proj_no");
		if(proj_no == null) {
			throw new NotValidSessionException();
		}
		return proj_no;
	}
	

}
