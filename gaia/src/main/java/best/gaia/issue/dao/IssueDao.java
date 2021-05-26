package best.gaia.issue.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;
import best.gaia.vo.PagingVO;


@Repository
public interface IssueDao {
	
	/**
	 * @param pagingVO
	 * @return issue count
	 */
	public int selectIssueCount(PagingVO<IssueVO> pagingVO);
	
	/**
	 * @param pagingVO
	 * @return issue list
	 */
	public List<IssueVO> selectIssueList(PagingVO<IssueVO> pagingVO);
	
	/**
	 * @param issue_id
	 * @return issue
	 */
	public IssueVO selectIssue(Map<String, Object> search);
	
	/**
	 * @param issue
	 * @return affected rows count
	 */
	public int insertIssue(IssueVO issue);
	
	/**
	 * @param issue
	 * @return affected rows count
	 */
	public int updateIssue(IssueVO issue);
	
	/**
	 * @param issue_id
	 * @return affected rows count
	 */
	public int deleteIssue(IssueVO search);
	
	/**
	 * @param pagingVO
	 * @return MilestoneList
	 */
	public List<MilestoneVO> selectMilestoneList(PagingVO<MilestoneVO> pagingVO);
	
	public MilestoneVO selectMilestone(Map<String, Object> search);
	
	public int insertMilestone(MilestoneVO milestone);
	
	public int updateMilestone(MilestoneVO milestone);
	
	public int deleteMilestone(MilestoneVO search);
	
}
