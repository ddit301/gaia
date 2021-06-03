package best.gaia.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.service.MemberService;
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
	
	
	@RequestMapping(method=RequestMethod.GET)
	public List<MemberVO> selectMemberList() {
		return null;
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
	@PutMapping
	public Map<String, Object> updateMember(
			HttpSession session,
			@ModelAttribute("profile") MemberVO profile
			) {
		int mem_no = 1;
		logger.info("method_post");
		logger.info("{}", profile.toString());
		Map<String, Object> member = new HashMap<String, Object>();
		member.put("member", profile);
		return member;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteMember(	) {
		return null;
	}
	
	/**
	 * memberVO에 대한 값만 조회합니다.
	 * @param MemberVO search
	 * @return
	 */
	@RequestMapping(value="/member", method=RequestMethod.GET)
	public MemberVO selectMemberVO(
				@ModelAttribute("search") MemberVO search
			) {
		int mem_no = 1;
		search = service.retrieveMemberByNo(mem_no);
		return search;
	}
	
	/**
	 * memberVO, ProjectVO, Issue에 대한 정보들을 조회합니다.
	 * @param MemberVO search
	 * @return
	 */
	@RequestMapping(value="{mem_no}", method=RequestMethod.GET)
	public MemberVO selectMember(
				@PathVariable Integer mem_no
				,@ModelAttribute("search") MemberVO search
			) {
		search = service.retrieveMemberProjectIssue(mem_no);
		return search;
	}
	/**
	 * 프로필사진 업로드 하기.
	 * @param form_data
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value="/member", method=RequestMethod.POST)
	public Map<String, Object> updateMemberProfilePicture(
				@ModelAttribute("form_data") MemberVO form_data	
			) throws IllegalStateException, IOException {
		// session에서 mem_no 받아오기
		int mem_no = 2;
		logger.info("{post 들어}");
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
		}
		logger.info("{}", filePath);
		Map<String, Object> file = new HashMap<String, Object>();
		file.put("fileName", fileName);
		return file;
	}
}
