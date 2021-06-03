package best.gaia.issue.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.issue.dao.IssueDao;
import best.gaia.issue.dao.MilestoneDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueHistoryVO;
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
			IssueHistoryVO history = issue.getHistoryList().get(0);
			history.setMem_no(issue.getMem_no());
			history.setIssue_sid(issue.getIssue_sid());
			history.setIssue_his_type("RE");
			result *= dao.insertIssueHistory(history);
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
		
		// totalRecord를 조회한 후 setter를 호출하여 등록 한다.
		int totalRecord = dao.selectIssueCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
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
		int result = milestoneDao.insertMilestone(milestone);
		
		return result==1? ServiceResult.OK : ServiceResult.FAIL;	
	}

	@Override
	public ServiceResult updateMilestone(MilestoneVO milestone) {
		int result = milestoneDao.updateMilestone(milestone);
		
		return result==1? ServiceResult.OK : ServiceResult.FAIL;	
	}

	@Override
	public ServiceResult deleteMilestone(MilestoneVO search) {
		int result = milestoneDao.deleteMilestone(search);
		
		return result==1? ServiceResult.OK : ServiceResult.FAIL;	
	}

	@Override
	public MilestoneVO selectMilestone(Map<String, Object> search) {
		return milestoneDao.selectMilestone(search);
	}


}
