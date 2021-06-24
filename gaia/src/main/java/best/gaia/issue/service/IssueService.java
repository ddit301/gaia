package best.gaia.issue.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;
import best.gaia.vo.PagingVO;

/**
 * 
 * 이슈와 마일스톤에 대한 서비스 객체 입니다.
 * 
 * @author Shane
 * @since 24 May 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 24 May 2021  Shane    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 */
public interface IssueService {
	
	/**
	 * 페이징 처리를 위해 이슈 갯수 카운팅
	 * @param pagingVO
	 * @return
	 */
	public int selectIssueCount(PagingVO<IssueVO> pagingVO);
	
	/**
	 * 이슈 목록 요청
	 * @param pagingVO
	 * @return
	 */
	public List<IssueVO> selectIssueList(PagingVO<IssueVO> pagingVO);
	
	/**
	 * 이슈 상세 조회
	 * @param search
	 * @return
	 */
	public IssueVO selectIssue(Map<String, Object> search);
	
	/**
	 * 새로운 이슈 생성
	 * @param issue
	 * @return
	 */
	public ServiceResult insertIssue(IssueVO issue);
	public ServiceResult updateIssue(int issue_sid, String editpart, Optional<String> parameter);
	
	/**
	 * 이슈 삭제
	 * @param search
	 * @return
	 */
	public ServiceResult deleteIssue(IssueVO search);
	
	public ServiceResult insertIssueHistory(IssueVO issue);
	
	/**
	 * 페이징 처리를 위한 마일스톤 갯수 카운팅
	 * @param pagingVO
	 * @return
	 */
	public int selectMilestoneCount(PagingVO<MilestoneVO> pagingVO);
	
	/**
	 * 마일스톤 목록 요청
	 * @param pagingVO
	 * @return
	 */
	public List<MilestoneVO> selectMilestoneList(PagingVO<MilestoneVO> pagingVO);
	
	/**
	 * gantt chart의 데이
	 * @param proj_no
	 * @return
	 */
	public List<MilestoneVO> selectMilestoneList(int proj_no);
	
	
	/**
	 * 마일스톤 상세 조회
	 * @param search
	 * @return
	 */
//	public MilestoneVO selectMilestone(MilestoneVO search);
	
	/**
	 * 새로운 마일스톤 생성
	 * @param milestone
	 * @return
	 */
	public ServiceResult insertMilestone(MilestoneVO milestone);
	
	/**
	 * 마일스톤 수정
	 * @param milestone
	 * @return
	 */
	public ServiceResult updateMilestone(MilestoneVO milestone);
	
	
	/**
	 * 마일스톤 삭제
	 * @param milestone
	 * @return
	 */
	public ServiceResult deleteMilestone(MilestoneVO search);

	public MilestoneVO selectMilestone(Map<String, Object> search);
	
	public ServiceResult closeManyIssues(List<Integer> issueSids, int mem_no);
}
