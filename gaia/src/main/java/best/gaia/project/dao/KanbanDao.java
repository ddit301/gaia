package best.gaia.project.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.KanbanColumnVO;
import best.gaia.vo.PagingVO;

@Repository
public interface KanbanDao {
	
	public List<KanbanColumnVO> selectKanbanColumnList(int project_no);
	public int insertKanbanColumn(KanbanColumnVO KanbanColumn);
	public int updateKanbanColumn(KanbanColumnVO KanbanColumn);
	public int deleteKanbanColumn(KanbanColumnVO KanbanColumn);
	
	public KanbanCardVO selectCard(int kb_card_no);
	public Integer getLastCardNo(int kb_col_no);
	public int updateCard(KanbanCardVO card);
	
}
