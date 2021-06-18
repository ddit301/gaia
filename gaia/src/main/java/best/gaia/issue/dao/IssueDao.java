package best.gaia.issue.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProjMemVO;


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
	public int updateIssue(Map<String, Object> map);
	
	/**
	 * @param issue_id
	 * @return affected rows count
	 */
	public int deleteIssue(IssueVO search);
	
	public int insertIssueHistory(IssueHistoryVO history);
	public int updateIssueHistory(IssueHistoryVO history);
	public int deleteIssueHistory(IssueHistoryVO history);
	
	public int deleteLabelFromIssue(int label_no);
	
	/**
	 * @param assignee (mem_no, issue_sid)
	 * @return
	 */
	public int insertIssueAssignee(Map<String, Integer> assignee);
	/**
	 * @param paramMap (mem_no, issue_sid)
	 * @return
	 */
	public int deleteIssueAssignee(Map<String, Integer> assignee);
	
	/**
	 * for issue history 
	 */
	
	public String selectMilestoneTitle(int milest_sid);
	/**
	 * @param param ( proj_no, mem_no ) 
	 * @return
	 */
	public String selectMemProjNick(ProjMemVO projMem);
	public String selectLabelName(int label_no);
	
}
