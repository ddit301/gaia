package best.gaia.calendar.service;

import java.util.List;
import java.util.Map;

import best.gaia.vo.IssueVO;

/**
 * 
 * Calendar에 대한 Service interface 입니다.
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
public interface CalendarService {
	public Map<String, Object> selectMilestoneIssuesByProj_no(int proj_no);
}
