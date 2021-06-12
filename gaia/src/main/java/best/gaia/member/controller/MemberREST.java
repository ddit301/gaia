package best.gaia.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.service.LogService;
import best.gaia.member.service.MemberService;
import best.gaia.utils.CookieUtil;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AttachFileVO;
import best.gaia.vo.MemberVO;
import static best.gaia.utils.SessionUtil.*;

@RestController
@RequestMapping(value="restapi/member/members", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberREST {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberREST.class);
	@Inject
	private MemberService service;
	
	@Inject
	private LogService logService;
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
//	@Value("#{appInfo.attatchPath}")
//	private File folder;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
		logger.info("{}", application.getRealPath("profiles"));
	}
	
	/**
	 * need 따라 조회하는 결과물이 다릅니다.
	 * if(need="MemberProjectIssue") 
	 * 		memberVO, ProjectVO, Issue에 대한 정보들을 조회합니다.
	 * if(...)
	 * @param MemberVO search
	 * @return
	 */
	@GetMapping
	public Map<String, Object> selectMemberList(		
				@RequestParam(required=false) String need
				, @ModelAttribute("search") MemberVO search
				, Authentication authentication
			) {
		Map<String, Object> result = new HashMap<String, Object>();
		int mem_no = getMemberNoFromAuthentication(authentication);
		logger.info("GET 들어옴, need : {}", need);
		// member/overview.jsp
		if("MemberProjectIssue".equals(need)) {
			search = service.retrieveMemberProjectIssue(mem_no);
		// member/securityLog.jsp
		}else if("logList".equals(need)){
			search = service.retrieveMemberByNo(mem_no);
			List<Map<String, Object>> logList = logService.selectLogList(mem_no);
			result.put("logList", logList);
		// member/profile.jsp, member/account.jsp
		}else {
			search = service.retrieveMemberByNo(mem_no);
			List<Map<String, Object>> memberStatusList = service.memberStatusList();
			result.put("memberStatusList", memberStatusList);
		}
		result.put("search", search);
		return result;
	}
	
	@GetMapping(params = {"need=profileImg"})
	public List<Map<String, Object>> selectMemberLogList(
				@RequestParam() String need
				,Authentication authentication 
			){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		int mem_no = getMemberNoFromAuthentication(authentication);
		result = logService.selectLogList(mem_no);
		return result;
	}
	
	
	/**
	 *  맴버 추가하기(사용안함)
	 * @param profile
	 * @param authentication
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertMember(
			@RequestBody MemberVO profile
			,Authentication authentication
			) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		Map<String, Object> member = new HashMap<String, Object>();
		member.put("member", profile);
		return member;
	}
	/**
	 * 프로필 설정 업로드 하기.
	 * @param form_data
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateMember(
			HttpSession session
			, @ModelAttribute("form_data") MemberVO form_data
			, @RequestParam(required=false) String need
			, Authentication authentication
			) throws IOException {
		int mem_no = getMemberNoFromAuthentication(authentication);
		form_data.setMem_no(mem_no);
		
		ServiceResult sr = service.modifyMember(form_data);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("sr", sr);
		return result;
	}
	@RequestMapping(method=RequestMethod.PUT, params = {"need=profileImg"})
	public Map<String, Object> updateMemberProfileImg(
			HttpSession session
			, @ModelAttribute("form_data") MemberVO form_data
			, @RequestParam(required=false) String need
			, Authentication authentication
			, HttpServletResponse response
			) throws IOException {
		int mem_no = getMemberNoFromAuthentication(authentication);
		form_data.setMem_no(mem_no);
		
		// file 객체 하나 뽑기 
		String saveFolder = "resources/profiles";
		
		// webResourcePath로 경로 잡기.(tomcatserver에 저장)
		String saveFolderPath = application.getRealPath(saveFolder);
		String fileName = "";
		List<AttachFileVO> files = form_data.getAttachFileList();
		for(AttachFileVO file : files) {
			fileName = String.valueOf(mem_no);
			file.saveTo(saveFolderPath, fileName);
			form_data.setMem_pic_file_name(fileName);
		}
		
		ServiceResult sr = service.modifyMember(form_data);
		
		// cookie에 저장하기.
		if(ServiceResult.OK.equals(sr)) {
			CookieUtil.addCookie("mem_pic_file_name", fileName, response);
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("sr", sr);
		return result;
	}
	@RequestMapping(method=RequestMethod.PUT, params = {"need=mem_nm"})
	public Map<String, Object> updateMemberNm(
			HttpSession session
			, @ModelAttribute("form_data") MemberVO form_data
			, @RequestParam(required=false) String need
			, Authentication authentication
			) throws IOException {
		int mem_no = getMemberNoFromAuthentication(authentication);
		form_data.setMem_no(mem_no);
		if(form_data.getMem_nm().isEmpty()) {
			form_data.setMem_nm("anonymous");
		}
		ServiceResult sr = service.modifyMember(form_data);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("member", form_data);
		result.put("sr", sr);
		return result;
	}
	@RequestMapping(method=RequestMethod.PUT, params = {"need=mem_password"})
	public Map<String, Object> updateMemberPass(
			HttpSession session
			, @ModelAttribute("form_data") MemberVO form_data
			, @RequestParam(required=false) String need
			, @RequestParam() String old_pass
			, Authentication authentication
			) throws IOException {
		int mem_no = getMemberNoFromAuthentication(authentication);
		form_data.setMem_no(mem_no);
		
		ServiceResult sr = service.modifyMemberPass(form_data, old_pass);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("member", form_data);
		result.put("sr", sr);
		return result;
	}
	
	/**
	 * 맴버 삭제하기(사용안함)
	 * @param authentication
	 * @return
	 */
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteMember(	
			Authentication authentication) {
		return null;
	}
}
