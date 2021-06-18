package best.gaia.project.service;
import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.issue.dao.IssueDao;
import best.gaia.member.dao.MemberDao;
import best.gaia.project.dao.KanbanDao;
import best.gaia.project.dao.NewsDao;
import best.gaia.project.dao.ProjectDao;
import best.gaia.project.dao.WikiDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.KanbanColumnVO;
import best.gaia.vo.LabelVO;
import best.gaia.vo.MemRoleVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProjMemVO;
import best.gaia.vo.ProjectVO;
import best.gaia.vo.WikiVO;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Inject
	private ProjectDao projectDao;
	@Inject
	private NewsDao newsDao;
	@Inject
	private KanbanDao kanbanDao;
	@Inject
	private WikiDao wikiDao;
	@Inject
	private MemberDao memDao;
	@Inject
	private IssueDao issueDao;
	
	
	
	@Override
	public List<NewsVO> selectNewsList(PagingVO<NewsVO> pagingVO) {
		// totalRecord를 조회한 후 setter를 호출하여 등록 한다.
		int totalRecord = newsDao.selectNewsCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		return newsDao.selectNewsList(pagingVO);
	}

	@Override
	public ServiceResult insertNews(NewsVO news) {
		int result = newsDao.insertNews(news);
		return result == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult updateNews(NewsVO news) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult deleteNews(NewsVO news) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	@Transactional
	public ServiceResult moveCard(Integer droppedCardNo, Integer newColumnNo, Integer nextCardNo) {
		// 드랍된 카드 정보 받아오기
		KanbanCardVO droppedCard = kanbanDao.selectCard(droppedCardNo);
		KanbanCardVO previousNextCard = null;
		KanbanCardVO currentNextCard = null;
		// 드랍된 카드의 previousNextCard 정보
		if (droppedCard.getKb_card_next_no() != null) {
			previousNextCard = kanbanDao.selectCard(droppedCard.getKb_card_next_no());
		}
		// 드랍된 카드의 현재 다음 카드 정보
		if (nextCardNo != null) {
			currentNextCard = kanbanDao.selectCard(nextCardNo);
		}

		if (previousNextCard != null) {
			// previousNextCard가 droppedCard의 priv_no를 priv_no 로 가진다.
			previousNextCard.setKb_card_priv_no(droppedCard.getKb_card_priv_no());
		}

		// droppedCard의 이전 카드 정보를 현재 다음 카드의 이전 카드 넘버에서 가져와 수정한다.
		if (currentNextCard == null) {
			// 새로운 자리에 다음 카드가 없다면, 이사 온 컬럼의 마지막 카드를 priv_no 로 갖는다.
			Integer lastCardNo = kanbanDao.getLastCardNo(newColumnNo);
			droppedCard.setKb_card_priv_no(lastCardNo);
		} else {
			// 새로운 자리에 다음 카드가 있으면 해당 카드의 이전 카드 번호를 뺐어온다.
			droppedCard.setKb_card_priv_no(currentNextCard.getKb_card_priv_no());
			// 현재 다음 카드의 이전카드 정보를 dropped card no 로 수정한다.
			currentNextCard.setKb_card_priv_no(droppedCardNo);
		}
		// droppedCard의 column 값을 현재 다음 카드의 column 값으로 수정한다.
		droppedCard.setKb_col_no(newColumnNo);

		// 변경이 있었던 세 개의 칸반 카드 정보를 모두 업데이트 한다.
		// 쿼리를 세번 쏘지만, 하나의 트랜잭션으로 관리

		int validChecker = 1;
		if (previousNextCard != null) {
			validChecker *= kanbanDao.updateCard(previousNextCard);
		}
		validChecker *= kanbanDao.updateCard(droppedCard);
		if (currentNextCard != null) {
			validChecker *= kanbanDao.updateCard(currentNextCard);
		}

		if (validChecker == 1) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAIL;
		}
	}

	@Override
	public ServiceResult insertCard(KanbanCardVO card) {
		
		// 카드에는 kb_col_no, kb_card_cont, mem_no 정보가 담겨서 넘어왔다.

		// card_priv_no 를 먼저 받아와서 카드 객체에 넣어준다.
		// 속한 컬럼의 마지막 카드 번호가 priv_no 가 된다. null이 있을 수 있으니 꼭 Integer로 해야 한다.
		Integer card_priv_no = kanbanDao.getLastCardNo(card.getKb_col_no());
		card.setKb_card_priv_no(card_priv_no);

		// kanbanDao 의 insert 문을 실행한다.
		int result = kanbanDao.insertCard(card);

		return result == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public List<WikiVO> historyWiki(PagingVO<WikiVO> pagingVO) {
		
		return wikiDao.historyWiki(pagingVO);
	}
	

	@Override
	public List<WikiVO> selectWikiList(PagingVO<WikiVO> pagingVO) {
		
		return wikiDao.selectWikiList(pagingVO);
	}
	
	@Override
	public WikiVO selectWiki(Map<String,Object> search) {
		
		return wikiDao.selectWiki(search);
	}

	@Override
	public ServiceResult insertWiki(WikiVO wiki) {
		int result = wikiDao.insertWiki(wiki);
		return result == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult updateWiki(WikiVO wiki) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult deleteWiki(WikiVO search) {
		int result = wikiDao.deleteWiki(search);
		
		return result==1? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	public String getProjectNick(int proj_no, int mem_no) {
		Map<String, Object> projnoMemno = new HashMap<>();
		projnoMemno.put("proj_no", proj_no);
		projnoMemno.put("mem_no", mem_no);
		return projectDao.getProjectNickNameByMemNo(projnoMemno);
	}

	@Override
	@Transactional
	public ServiceResult deleteCard(KanbanCardVO card) {
		int validChecker = 1;
		// 삭제할 카드의 정보를 조회하고
		card = kanbanDao.selectCard(card.getKb_card_no());
		
		// 삭제할 카드의 다음 카드의 previousCard 에 삭제할 카드의 previousCard 값을 넣어 업데이트 하고
		if(card.getKb_card_next_no() != null) {
			KanbanCardVO nextCard = new KanbanCardVO();
			nextCard.setKb_card_no(card.getKb_card_next_no());
			nextCard.setKb_card_priv_no(card.getKb_card_priv_no());
			validChecker *= kanbanDao.updateCard(nextCard);
		}
		
		// 삭제할 카드를 삭제해준다.
		validChecker *= kanbanDao.deleteCard(card);
		return validChecker == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public Boolean isProjTitleValid(Authentication authentication, String proj_title) {
		int mem_no = getMemberNoFromAuthentication(authentication);
		ProjectVO project = new ProjectVO();
		project.setMem_no(mem_no);
		project.setProj_title(proj_title);
		int count = projectDao.getProjCount(project);
		return (count == 0);
	}

	@Override
	@Transactional
	public ServiceResult insertProject(ProjectVO project) {
		int mem_no = project.getMem_no();
		int validChecker = 1;
		
		// 프로젝트 생성 해주고
		validChecker *= projectDao.insertProject(project);
		int proj_no = project.getProj_no();
		
		// 프로젝트에 기본 멤버 롤 생성해서insert 등록 하고 ( Manager, member )
		MemRoleVO adminRole = new MemRoleVO(proj_no,"관리자",4095);
		MemRoleVO memberRole = new MemRoleVO(proj_no,"회원",2998);
		validChecker *= projectDao.insertMemberRole(adminRole);
		validChecker *= projectDao.insertMemberRole(memberRole);
		
		// 프로젝트 생성자 가입 정보 등록하고 (Manager)
		ProjMemVO projMem = new ProjMemVO();
		projMem.setMem_no(mem_no);
		projMem.setMem_role_no(adminRole.getMem_role_no());
		projMem.setProj_no(proj_no);
		projMem.setProj_user_nick("관리자");
		validChecker *= projectDao.insertProjMem(projMem);
		
		// 해당 프로젝트에 기본 칸반 컬럼들 등록해준다. ( Todo, In Progress, Done)
		KanbanColumnVO firstColumn = new KanbanColumnVO("TO DO");
		firstColumn.setProj_no(proj_no);
		validChecker *= kanbanDao.insertKanbanColumn(firstColumn);
		
		KanbanColumnVO secondColumn = new KanbanColumnVO("IN PROGRESS");
		secondColumn.setProj_no(proj_no);
		secondColumn.setKb_col_priv_no(firstColumn.getKb_col_no());
		validChecker *= kanbanDao.insertKanbanColumn(secondColumn);
		
		KanbanColumnVO thirdColumn = new KanbanColumnVO("DONE");
		thirdColumn.setProj_no(proj_no);
		secondColumn.setKb_col_priv_no(secondColumn.getKb_col_no());
		validChecker *= kanbanDao.insertKanbanColumn(thirdColumn);
		
		// 프로젝트에 기본 라벨들을 생성해 insert 합니다.
		validChecker *= projectDao.insertLabel(new LabelVO(proj_no, "일감", "icon-star", "#f8f8f8"));
		validChecker *= projectDao.insertLabel(new LabelVO(proj_no, "버그", "icon-close", "#f7ca88"));
		validChecker *= projectDao.insertLabel(new LabelVO(proj_no, "도움요청", "icon-pin", "#d8d8d8"));
		
		return validChecker == 1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult updateProject(ProjectVO project) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult deleteProject(ProjectVO project) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProjMemVO> selectProjectMembers(int proj_no, String searchword) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("proj_no",proj_no);
		if(searchword != null)
			paramMap.put("searchword",searchword);
		return memDao.selectProjectMembers(paramMap);
	}

	@Override
	@Transactional
	public ServiceResult deleteLabel(int label_no) {
		
		// 해당하는 라벨을 라벨번호로 가지고 있는 모든 이슈들 라벨번호 null로 바꾸고
		issueDao.deleteLabelFromIssue(label_no);
		// 라벨을 삭제한다
		int result = projectDao.deleteLabel(label_no);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
		
	}

	@Override
	@Transactional
	public ServiceResult insertAndUpdateMemroles(int proj_no, List<MemRoleVO> newRoles, List<MemRoleVO> editRoles) {
		
		int newSize = newRoles.size();
		int insertSize = editRoles.size();
		
		// 새로운 role들이 추가 되었으면 insert 해주기
		for(MemRoleVO memRole : newRoles) {
			memRole.setProj_no(proj_no);
			newSize -= projectDao.insertMemberRole(memRole);
		}
		
		// 수정된 role들 업데이트 해주기
		for(MemRoleVO memRole : editRoles) {
			insertSize -= projectDao.updateMemberRole(memRole);
		}
		
		ServiceResult result = ServiceResult.FAIL;
		if (newSize == 0 && insertSize ==0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}

}








