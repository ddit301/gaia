package best.gaia.calendar.controller;

import static best.gaia.utils.SessionUtil.*;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.calendar.dao.CalendarDao;
import best.gaia.calendar.service.CalendarService;
import best.gaia.utils.enumpkg.ServiceResult;
/**
 * 
 * Calendar에 대한 객체입니다.
 * 
 * @author Eisen
 * @since ${date}
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * ${date}  Eisen    Initial Commit
 * Copyright (c) ${year} by Team Gaia All right reserved
 * </pre>
 */

@RestController
@RequestMapping(value="restapi/project/calendar", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class CalendarREST {

	@Inject
	private CalendarDao dao;
	
	@Inject
	private CalendarService service;
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarREST.class);
	
	@GetMapping
	public Map<String, Object> selectMilestoneIssueInfoList(
			HttpSession session
			){
		int proj_no = getProjNoFromSession(session);
		service.selectMilestoneIssuesByProj_no(proj_no);
		
		return service.selectMilestoneIssuesByProj_no(proj_no);
	}
	
	@PutMapping
	public int updateStatus(
			@RequestParam(required=false) String need
			, @RequestParam Map<String, Object> dataMap
			){
		int result = 0;
		logger.info("Put in");
		logger.info("need : {}", need);
		logger.info("dataMap : {}", dataMap);
		if("yes".equals(dataMap.get("isChangeDate"))) {
			result = 3;
		}else {
			if("issue".equals(need)) {
				result = dao.updateIssueStatus(dataMap);
			}else if("milestone".equals(need)) {
				result = dao.updateMilestoneStatus(dataMap);
			}
		}
		return result;
	}
}
