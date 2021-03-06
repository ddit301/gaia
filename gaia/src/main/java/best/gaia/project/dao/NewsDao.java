package best.gaia.project.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.NewsCommentVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;

@Repository
public interface NewsDao {
	
	public List<NewsVO> selectNewsList(PagingVO<NewsVO> pagingVO);
	public int selectNewsCount(PagingVO<NewsVO> pagingVO);
	public int insertNews(NewsVO news);
	public int updateNews(NewsVO news);
	public int deleteNews(NewsVO news);
	
	public int insertNewsComment(NewsCommentVO newsComment);
	public int updateNewsComment(NewsCommentVO newsComment);
	public int deleteNewsComment(NewsCommentVO newsComment);
	
}
