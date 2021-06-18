package best.gaia.calendar.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.calendar.dao.CalendarDao;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;

/**
 * 
 * Calendar에 대한 Service 객체 입니다.
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
@Service
public class CalendarServiceImpl implements CalendarService{

	@Inject
	CalendarDao dao;
	
	@Override
	@Transactional
	public Map<String, Object> selectMilestoneIssuesByProj_no(int proj_no) {
		List<IssueVO> issueList = dao.selectIssuesByProj_no(proj_no);
		List<MilestoneVO> milestoneList = dao.selectMilestoneByProj_no(proj_no);
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("issueList", issueList);
		result.put("milestoneList", milestoneList);
		return result;
	}

}
