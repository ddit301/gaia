package best.gaia.member.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.service.IMemberService;
import best.gaia.vo.MemberVO;

@RestController
@RequestMapping(value="restapi/member/members", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberREST {
	
	@Inject
	private IMemberService service;
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
	public Map<String, Object> insertMember() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateMember() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteMember() {
		return null;
	}
	
	
	
	

}
