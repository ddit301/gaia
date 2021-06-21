package best.gaia.calendar.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.IssueVO;
import best.gaia.vo.LabelVO;
import best.gaia.vo.MilestoneVO;

@Repository
public interface CalendarDao {
	public List<IssueVO> selectIssuesByProj_no(int proj_no);
	public List<MilestoneVO> selectMilestoneByProj_no(int proj_no);
	public List<LabelVO> labelList(int proj_no);
	public int updateIssueStatus(Map<String, Object> issueSidStatus);
	public int updateMilestoneStatus(Map<String, Object> milestSidStatus);
	public int updateIssueDate(Map<String, Object> issueInfo);
}
