package best.gaia.provider.controller;

import static best.gaia.utils.SessionUtil.getProjNoFromSession;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.provider.service.ProviderService;
import best.gaia.vo.InquiryVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

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

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	@GetMapping(value = "ListView", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<InquiryVO> listForAjax(
			@RequestParam(value = "listLength", required = false, defaultValue = "20") int listLength) {
		List<InquiryVO> inqList = service.retrieveAllInquiry();

		return inqList;
	}
	
//	@GetMapping
//	public PagingVO<IssueVO> selectIssueList(
//			HttpSession session
//			,@ModelAttribute PagingVO<IssueVO> pagingVO
//			,@ModelAttribute IssueVO detailSearch
//			) {
//		// session 에서 프로젝트 번호를 받아와 detailSearch에 등록합니다.
//		detailSearch.setProj_no(getProjNoFromSession(session));
//		pagingVO.setDetailSearch(detailSearch);
//		
//		// issueList 를 받아와 pagingVO 에 담는다.
//		List<IssueVO> issueList = service.selectIssueList(pagingVO);
//		pagingVO.setDataList(issueList);
//		
//		// pagingVO 형태로 값을 반환한다.
//		return pagingVO;
//	}
//	
	
	

}