package best.gaia.member.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.service.MemberService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AttachFileVO;
import best.gaia.vo.MemberVO;

@RestController
@RequestMapping(value="restapi/member/members", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberREST {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberREST.class);
	@Inject
	private MemberService service;
	
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
	 * need가 없을 시 memberVO에 대한 값만 조회합니다.
	 * if(need=MemberProjectIssue) 
	 * 		memberVO, ProjectVO, Issue에 대한 정보들을 조회합니다.
	 * if(...)
	 * @param MemberVO search
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET)
	public Map<String, Object> selectMemberList(		
				@RequestParam(required=false) String need
				,@ModelAttribute("search") MemberVO search
			) {
		logger.info("GET 들어옴, need : {}", need);
		// session 불러오기
		int mem_no = 3;
		
		// need로 특정 요청 판단하기
		if("MemberProjectIssue".equals(need)) {
			logger.info("{}", need);
			// member/overview.jsp
			search = service.retrieveMemberProjectIssue(mem_no);
		}else {
			// member/profile.jsp, member/account.jsp
			search = service.retrieveMemberByNo(mem_no);
		}
		if(search.getMem_pic_file_name() == null) {
			search.setMem_pic_file_name("default.jpeg");  
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("search", search);
		return result;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertMember(
			@RequestBody MemberVO profile
			) {
		int mem_no = 1;
		logger.info("ㄷ르어오긴 함_up");
		logger.info("{}", profile.toString());
		Map<String, Object> member = new HashMap<String, Object>();
		member.put("member", profile);
		return member;
	}
	/**
	 * 프로필사진 업로드 하기.
	 * @param form_data
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateMember(
			HttpSession session,
			@ModelAttribute("form_data") MemberVO form_data,
			HttpServletRequest res,
			@RequestParam(required=false) String need
			) throws IOException {
		// session에서 mem_no 받아오기
		int mem_no = 1;
		
		// need로 특정 요청 판단하기
		if("profileImg".equals(need)) {
			// member/profile.jsp
			logger.info("PUT, {}", need);
			// file 객체 하나 뽑기 
			String filePath = "";
			String saveFolder = "resources/profiles";
			String saveFolderPath = application.getRealPath(saveFolder);
			String fileName = "";
			List<AttachFileVO> files = form_data.getAttachFileList();
			for(AttachFileVO file : files) {
				int dot = file.getFile_nm().lastIndexOf(".");
				String mime= file.getFile_nm().substring(dot);
				fileName = mem_no+mime;
				file.saveTo(saveFolderPath, fileName);
				filePath = saveFolderPath+"/"+fileName;
				form_data.setMem_no(mem_no);
				form_data.setMem_pic_file_name(fileName);
			}
			service.modifyMember(form_data);
			Map<String, Object> file = new HashMap<String, Object>();
			file.put("fileName", fileName);
			return file;
		}else {
			// member/profile.jsp, account.jsp
			ServiceResult result = service.modifyMember(form_data);
			Map<String, Object> member = new HashMap<String, Object>();
			member.put("member", form_data);
			return member;
			// member/overview.jsp
		}
	}
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteMember(	) {
		return null;
	}
}
