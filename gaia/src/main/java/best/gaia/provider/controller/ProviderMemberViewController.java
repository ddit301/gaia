package best.gaia.provider.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.provider.service.ProviderService;
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
public class ProviderMemberViewController {

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
	public List<MemberVO> listForAjax(
			@RequestParam(value = "listLength", required = false, defaultValue = "20") int listLength) {
		List<MemberVO> memberList = service.retrieveAllMember();

		return memberList;
	}

}
