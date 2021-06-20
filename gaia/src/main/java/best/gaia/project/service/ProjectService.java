package best.gaia.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.MemRoleVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProjMemVO;
import best.gaia.vo.ProjectVO;
import best.gaia.vo.WikiVO;

public interface ProjectService {
	
	/**********************************************************************
	 *  프로젝트 관련 service
	 **********************************************************************/	
	public Boolean isProjTitleValid(Authentication authentication, String proj_title);
	public ServiceResult insertProject(ProjectVO project);
	public ServiceResult updateProject(ProjectVO project);
	public ServiceResult deleteProject(ProjectVO project);
	
	/**********************************************************************
	 *  프로젝트 멤버 관련 service
	 **********************************************************************/
	public List<ProjMemVO> selectProjectMembers(int proj_no, String searchword);
	
	/**********************************************************************
	 *  프로젝트 멤버 역할관련 service
	 **********************************************************************/
	public ServiceResult insertAndUpdateMemroles(int proj_no, List<MemRoleVO> newRoles, List<MemRoleVO> editRoles);
	public ServiceResult deleteMemRole(int mem_role_no);
	
	/**********************************************************************
	 *  뉴스 관련 service
	 **********************************************************************/
	public List<NewsVO> selectNewsList(PagingVO<NewsVO> search);
	public ServiceResult insertNews(NewsVO news);
	public ServiceResult updateNews(NewsVO news);
	public ServiceResult deleteNews(NewsVO news);
	
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
	public List<WikiVO> historyWiki(PagingVO<WikiVO> pagingVO);

	/**********************************************************************
	 *  라벨 관련 service
	 **********************************************************************/	
	public ServiceResult deleteLabel(int label_no);
	
	
	
}




