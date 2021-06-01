package best.gaia.member.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.service.MemberService;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

@RestController
@RequestMapping(value="restapi/member/members", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberREST {
	
	@Inject
	private MemberService service;
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(MemberREST.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public List<MemberVO> selectMemberList() {
		return null;
	}
	
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertMember(
			) {
		
		return null;
	}
	
	@PutMapping
	public Map<String, Object> updateMember(
			HttpSession session,
			@ModelAttribute("profile") MemberVO profile
			) {
		int mem_no = 1;
		logger.info("ㄷ르어오긴 함_up");
		logger.info("{}", profile.toString());
		Map<String, Object> member = new HashMap<String, Object>();
		member.put("member", profile);
		return member;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteMember(	) {
		return null;
	}
	

	@RequestMapping(value="{mem_no}", method=RequestMethod.GET)
	public MemberVO selectMember(
				@PathVariable Integer mem_no
				,@ModelAttribute("search") MemberVO search
			) {
		search = service.retrieveMemberProjectIssue(mem_no);
		return search;
	}
	@RequestMapping(value="/member", method=RequestMethod.GET)
	public MemberVO selectMemberVO(
				@ModelAttribute("search") MemberVO search
			) {
		int mem_no = 1;
		search = service.retrieveMemberByNo(mem_no);
		return search;
	}
}
