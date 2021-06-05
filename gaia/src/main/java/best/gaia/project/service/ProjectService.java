package best.gaia.project.service;

import java.util.List;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.NewsCommentVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProjectVO;

public interface ProjectService {
	
	/**********************************************************************
	 *  뉴스 관련 service
	 **********************************************************************/
	public List<NewsVO> selectNewsList(PagingVO<NewsVO> search);
	public ServiceResult insertNews(NewsVO news);
	public ServiceResult updateNews(NewsVO news);
	public ServiceResult deleteNews(NewsVO news);
	
	/**********************************************************************
	 *  뉴스 댓글 관련 service
	 **********************************************************************/
	public ServiceResult insertNewsComment(NewsCommentVO news);
	public ServiceResult updateNewsComment(NewsCommentVO news);
	public ServiceResult deleteNewsComment(NewsCommentVO news);
	
	/**********************************************************************
	 *  칸반 관련 service
	 **********************************************************************/
	public ServiceResult moveCard(Integer droppedCardNo, Integer newColumnNo , Integer nextCardNo);
	public ServiceResult insertKanbanCard(KanbanCardVO card);
	
	
	
	public ServiceResult enrollProject(ProjectVO project);
	
}
