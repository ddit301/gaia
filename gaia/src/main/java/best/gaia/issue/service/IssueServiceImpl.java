package best.gaia.issue.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.issue.dao.IssueDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.PagingVO;

@Service
public class IssueServiceImpl implements IssueService {
	
	@Inject
	private IssueDao dao;

	@Override
	public ServiceResult insertIssue(IssueVO issue) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectIssueCount(PagingVO<IssueVO> pagingVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<IssueVO> selectIssueList(PagingVO<IssueVO> pagingVO) {
		return dao.selectIssueList(pagingVO);
	}

	@Override
	public IssueVO selectIssue(IssueVO search) {
		return dao.selectIssue(search);
	}

	@Override
	public ServiceResult updateIssue(IssueVO Issue) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult deleteIssue(IssueVO search) {
		// TODO Auto-generated method stub
		return null;
	}

}
