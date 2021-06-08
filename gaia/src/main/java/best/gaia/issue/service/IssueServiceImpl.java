package best.gaia.issue.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.elasticsearch.client.ElasticsearchClient;
import org.elasticsearch.common.Strings;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.internal.bind.JsonTreeWriter;

import best.gaia.alarm.dao.AlarmDao;
import best.gaia.alarm.service.AlarmService;
import best.gaia.issue.dao.IssueDao;
import best.gaia.issue.dao.MilestoneDao;
import best.gaia.utils.CookieUtil;
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
	private AlarmService alarmService;
	
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

	@Override
	@Transactional
	public ServiceResult insertIssueHistory(IssueVO issue) {
		// 일단 새로 생성한 history 를 insert 합니다.
		IssueHistoryVO issueHistory = issue.getHistoryList().get(0);
		int result = dao.insertIssueHistory(issueHistory);
		
		// 이슈에 댓글을 다는 경우에는 해당 이슈 작성자에게 알람을 보냅니다.
		if(result==1 && "RE".equals(issueHistory.getIssue_his_type())){
			return alarmService.insertIssueCommentAlarm(issue);
		}
		
		return result == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}


}
