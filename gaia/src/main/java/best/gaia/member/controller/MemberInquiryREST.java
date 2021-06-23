package best.gaia.member.controller;

import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;

import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.member.dao.MemberDao;
import best.gaia.member.service.MemberService;
import best.gaia.vo.AttachFileVO;
import best.gaia.vo.InquiryVO;

@RestController
@RequestMapping(value="restapi/member/inquiry", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberInquiryREST {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberInquiryREST.class);
	@Inject
	private MemberService service;
	
	@Inject
	private MemberDao dao;
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	@PostMapping
	public InquiryVO enrollInquiry(@ModelAttribute("form_data") InquiryVO inquiry
			, Authentication authentication) throws IOException {
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		inquiry.setMem_no(mem_no);
		String saveFolder = "resources/images/inquiry";
		String saveFolderPath = application.getRealPath(saveFolder);
		String fileName = "";
		List<AttachFileVO> files = inquiry.getAttachFileList();
		for(AttachFileVO file : files) {
			int atch_file_sid = service.insertInquiryFiles(file);
			
			fileName = String.valueOf(atch_file_sid);
			file.saveTo(saveFolderPath, fileName);
		}
		InquiryVO result = service.enrollInquiry(inquiry);//멤버 번호와 컨텐츠만 넘김 
		
		return result;
	}

}
