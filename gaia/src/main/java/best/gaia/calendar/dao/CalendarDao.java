package best.gaia.calendar.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;

@Repository
public interface CalendarDao {
	public List<IssueVO> selectIssuesByProj_no(int proj_no);
	public List<MilestoneVO> selectMilestoneByProj_no(int proj_no);
}
