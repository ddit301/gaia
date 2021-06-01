package best.gaia.issue.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.issue.dao.IssueDao;
import best.gaia.issue.dao.MilestoneDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;
import best.gaia.vo.PagingVO;

@Service
public class IssueServiceImpl implements IssueService {
	
	@Inject
	private IssueDao dao;
	
	@Inject
	private MilestoneDao milestoneDao;

	@Override
	@Transactional
	public ServiceResult insertIssue(IssueVO issue) {
		int result = dao.insertIssue(issue);
		if(result == 1) {
			// 이슈 댓글에 내용 넣기
		}
		return result == 1? ServiceResult.OK : ServiceResult.FAIL; 
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
		return milestoneDao.selectMilestoneList(pagingVO);
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
		return milestoneDao.selectMilestone(search);
	}


}
