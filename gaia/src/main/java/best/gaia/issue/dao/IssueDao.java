package best.gaia.issue.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.IssueVO;
import best.gaia.vo.PagingVO;


@Repository
public interface IssueDao {
	
	/**
	 * @param issue_id
	 * @return issue
	 */
	public IssueVO selectIssue(IssueVO search);
	
	/**
	 * @param pagingVO
	 * @return issue list
	 */
	public List<IssueVO> selectIssueList(PagingVO<IssueVO> pagingVO);
	
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
	public int deleteIssue(String issue_id);
	
}
