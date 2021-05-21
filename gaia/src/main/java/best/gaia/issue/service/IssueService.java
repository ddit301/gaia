package best.gaia.issue.service;

import java.util.List;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.PagingVO;

public interface IssueService {
	public ServiceResult insertIssue(IssueVO issue);
	public int selectIssueCount(PagingVO<IssueVO> pagingVO);
	public List<IssueVO> selectIssueList(PagingVO<IssueVO> pagingVO);
	public IssueVO selectIssue(IssueVO search);
	public ServiceResult updateIssue(IssueVO Issue);
	public ServiceResult deleteIssue(IssueVO search);
}
