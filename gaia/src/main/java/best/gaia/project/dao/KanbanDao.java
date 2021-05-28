package best.gaia.project.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.KanbanColumnVO;
import best.gaia.vo.PagingVO;

@Repository
public interface KanbanDao {
	
	public List<KanbanColumnVO> selectKanbanColumnList(int project_no);
	public int insertKanbanColumn(KanbanColumnVO KanbanColumn);
	public int updateKanbanColumn(KanbanColumnVO KanbanColumn);
	public int deleteKanbanColumn(KanbanColumnVO KanbanColumn);
	
}
