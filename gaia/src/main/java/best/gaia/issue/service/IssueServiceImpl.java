package best.gaia.issue.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.issue.dao.IssueDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;
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
	public IssueVO selectIssue(Map<String, Object> search) {
		return dao.selectIssue(search);
	}

	@Override
	public List<IssueVO> selectIssueList(PagingVO<IssueVO> pagingVO) {
		return dao.selectIssueList(pagingVO);
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

	@Override
	public List<MilestoneVO> selecMilestoneList(PagingVO<MilestoneVO> pagingVO) {
		return dao.selectMilestoneList(pagingVO);
	}

	@Override
	public int selectMilestoneCount(PagingVO<MilestoneVO> pagingVO) {
		// TODO Auto-generated method stub
		return 0;
	}

//	@Override
//	public MilestoneVO selectMilestone(MilestoneVO search) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public ServiceResult insertMilestone(MilestoneVO milestone) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult updateMilestone(MilestoneVO milestone) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult deleteMilestone(MilestoneVO search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MilestoneVO selectMilestone(Map<String, Object> search) {
		return dao.selectMilestone(search);
	}


}
