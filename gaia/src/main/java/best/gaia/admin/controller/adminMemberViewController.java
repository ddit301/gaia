package best.gaia.admin.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.admin.service.AdminService;
import best.gaia.vo.MemberVO;

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
@RequestMapping("admin/member")
public class adminMemberViewController {

	@Inject
	private AdminService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	
	@GetMapping("ListView")
	public String listForHTML(
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "searchWord", required = false) String searchWord,
			@RequestParam(value = "listLength", required = false, defaultValue = "20") int listLength
			, Model model
		) {
		List<MemberVO> pagingVO = listForAjax(listLength);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "board/boardList";
		
	}

	@GetMapping(value = "ListView", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<MemberVO> listForAjax(
//			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
//			@RequestParam(value = "searchType", required = false) String searchType,
//			@RequestParam(value = "searchWord", required = false) String searchWord,
			@RequestParam(value = "listLength", required = false, defaultValue = "20") int listLength) {
		List<MemberVO> memberList = service.retrieveAllMember();
//		pagingVO.setCurrentPage(currentPage);
//		Map<String, Object> searchMap = new HashMap<>();
//		searchMap.put("searchType", searchType);
//		searchMap.put("searchWord", searchWord);
//		pagingVO.setSearchMap(searchMap);
//
//		int totalRecord = service.retrieveBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<MemberVO> memberList = service.retrieveBoardList(pagingVO);
//		pagingVO.setDataList(memberList);

		return memberList;
	}

}
