package best.gaia.member.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.multipart.MultipartFile;

import best.gaia.member.service.MemberService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.ResourceNotFoundException;
import best.gaia.utils.exception.UnsupportedMediaTypeException;
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
	
	@Value("#{appInfo.attatchPath}")
	private File folder;
	private transient MultipartFile file;
	
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
			@ModelAttribute("profile") MemberVO profile,
			@RequestParam String AA
			) {
		int mem_no = 1;
		logger.info("ㄷ르어오긴 함_up"+AA);
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
	
	@PutMapping(value="/member")
	public String updateMemberProfilePicture(
			HttpSession session,
			@ModelAttribute("member") MemberVO member
			) throws IllegalStateException, IOException {
		logger.info("ㄷ르어오긴 함_up");
		logger.info("{}", member.toString());
		// session에서 mem_no 받아오기
		int mem_no = 1;
		member.setMem_no(mem_no);
		
		// request로 받은 파일의 이름을 mem_no로 변경.
//		member.setMem_pic_file_name(Integer.toString(mem_no));
		// mem_pic_file_name => ${user.home}/Documents/GitHub/gaia/attachFiles/1.jsp...로 저장되어야함.
		String imageFilename = member.getMem_pic_file_name();
		logger.info("{}", imageFilename);
		
		// update profile_img 실행
		ServiceResult result = service.modifyMemberProfileImage(member);
		
		// filesystem에 저장
		File imageFile = new File(folder, imageFilename);
		if(!imageFile.exists()) {
			throw new ResourceNotFoundException();
		}
		String mime = application.getMimeType(imageFilename);
		if(mime==null || !mime.startsWith("image/")) {
			throw new UnsupportedMediaTypeException();
		}
		file.transferTo(new File(imageFile, imageFilename));
		
		return member.getMem_pic_file_name();
	}
}
