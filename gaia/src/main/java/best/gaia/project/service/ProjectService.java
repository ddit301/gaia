package best.gaia.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.NewsCommentVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.WikiVO;
import best.gaia.vo.ProjectVO;

public interface ProjectService {
	
	/**********************************************************************
	 *  프로젝트 관련 service
	 **********************************************************************/	
	public Boolean isProjTitleValid(Authentication authentication, String proj_title);
	
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
	public ServiceResult insertCard(KanbanCardVO card);
	public ServiceResult deleteCard(KanbanCardVO card);
	
	/**
	 * @param proj_no
	 * @param mem_no
	 * @return 특정 proj_no 에 속한 mem_no 회원의 프로젝트 내 닉네임
	 */
	public String getProjectNick(int proj_no, int mem_no);
	
	/**********************************************************************
	 *  위키 관련 service
	 **********************************************************************/	
	public List<WikiVO> selectWikiList(PagingVO<WikiVO> pagingVO);
	public ServiceResult insertWiki(WikiVO wiki);
	public ServiceResult updateWiki(WikiVO wiki);
	public ServiceResult deleteWiki(WikiVO wiki);
	public WikiVO selectWiki(Map<String, Object> search);


	
}
