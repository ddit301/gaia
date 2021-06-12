package best.gaia.provider.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.provider.service.ProviderService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.InquiryCommentVO;
import best.gaia.vo.InquiryVO;

/**
 * 
 * @author Robin
 * @since 2021. 6. 1
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 2021. 6. 1  Robin    Initial Commit
 * Copyright (c) 2021 by team SEED All right reserved
 *      </pre>
 */

@Controller
@RequestMapping("admin/inquiry")
public class ProviderInquiryREST {

	@Inject
	private ProviderService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	private static final Logger logger = LoggerFactory.getLogger(ProviderInquiryREST.class);

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	@GetMapping(value = "QuestionListView", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<InquiryVO> questionForAjax(
			@RequestParam(value = "listLength", required = false, defaultValue = "20") int listLength) {
		List<InquiryVO> inqList = service.retrieveAllInquiryQuestion();

		return inqList;
	}

	@GetMapping(value = "Answer", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public InquiryCommentVO answerForAjax(@RequestParam int inq_no) {
		InquiryCommentVO commList = service.retrieveInquiryAnswer(inq_no);

		return commList;
	}

	@PostMapping(value = "Answer", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public InquiryCommentVO answerForm(Authentication authentication,
			@ModelAttribute InquiryCommentVO inquiryComment,  Model model) {
		
		InquiryCommentVO insertedInquiryComment = new InquiryCommentVO(); 
		
		logger.debug("auth: " + authentication);
//		String prov_id = authentication.getName();
		
		inquiryComment.setProv_id("admin22");

		Map<String, Object> resultMap = new HashMap<>();
		try {
			int inq_com_no = service.enrollInquiryAnswer(inquiryComment);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String inq_com_date =  sdf.format(Calendar.getInstance().getTime());
			inquiryComment.setInq_com_no(inq_com_no);
			inquiryComment.setInq_com_date(inq_com_date);
			insertedInquiryComment = inquiryComment;
			resultMap.put("result", ServiceResult.OK);
		}catch (Exception e) {
			resultMap.put("result", ServiceResult.FAIL);
		}
		return insertedInquiryComment;
	}

}