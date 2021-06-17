package best.gaia.project.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.PagingVO;
import best.gaia.vo.WikiVO;

@Repository
public interface WikiDao {
	
	public List<WikiVO> selectWikiList(PagingVO<WikiVO> pagingVO);
	public WikiVO selectWiki(Map<String, Object> search); 
	public WikiVO historyWiki(Map<String,Object> search);
	public int insertWiki(WikiVO wiki);
	public int updateWiki(WikiVO wiki);
	public int deleteWiki(WikiVO search);
	
}
