package best.gaia.project.service;

import java.util.List;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.NewsCommentVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;

public interface ProjectService {
	
	public List<NewsVO> selectNewsList(PagingVO<NewsVO> search);
	public ServiceResult insertNews(NewsVO news);
	public ServiceResult updateNews(NewsVO news);
	public ServiceResult deleteNews(NewsVO news);
	
	public ServiceResult insertNewsComment(NewsCommentVO news);
	public ServiceResult updateNewsComment(NewsCommentVO news);
	public ServiceResult deleteNewsComment(NewsCommentVO news);
	
	/**
	 * @param droppedCardNo
	 * @param nextCardNo
	 * @return
	 */
	public ServiceResult moveCard(Integer droppedCardNo, Integer newColumnNo , Integer nextCardNo);
	
}
