package best.gaia.issue.dao;

import java.util.List;
import java.util.Map;

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
	public MilestoneVO selectMilestone(Map<String, Object> search);
	
	public int insertMilestone(MilestoneVO milestone);
	
	public int updateMilestone(MilestoneVO milestone);
	
	public int deleteMilestone(MilestoneVO search);
	
}
