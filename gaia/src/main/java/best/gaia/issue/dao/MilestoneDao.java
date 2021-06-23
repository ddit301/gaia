package best.gaia.issue.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import best.gaia.vo.IssueVO;
import best.gaia.vo.MilestoneVO;
import best.gaia.vo.PagingVO;


@Repository
public interface MilestoneDao {
	
	
	/**
	 * @param pagingVO
	 * @return MilestoneList
	 */
	public List<MilestoneVO> selectMilestoneList(PagingVO<MilestoneVO> pagingVO);
	
	/**
	 * @param search
	 * @return
	 */
	// Map 에 @Param 으로 search 라는 이름을 줌.
	public MilestoneVO selectMilestone(@Param("search") Map<String, Object> search);
	
	public int insertMilestone(MilestoneVO milestone);
	
	public int updateMilestone(MilestoneVO milestone);
	
	public int deleteMilestone(MilestoneVO search);
	
	/**
	 * 해당 프로젝트의 모든 마일스톤과 이슈들의 정보를 받아옴.
	 * @param proj_no
	 * @return
	 */
	public List<MilestoneVO> selectMilestoneIssueList(int proj_no);
}
