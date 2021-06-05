package best.gaia.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.project.dao.KanbanDao;
import best.gaia.project.dao.NewsDao;
import best.gaia.project.dao.ProjectDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.NewsCommentVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProjectVO;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Inject
	private ProjectDao projectDao;
	@Inject
	private NewsDao newsDao;
	@Inject
	private KanbanDao kanbanDao;

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
	public ServiceResult insertNewsComment(NewsCommentVO news) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult updateNewsComment(NewsCommentVO news) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult deleteNewsComment(NewsCommentVO news) {
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
	public ServiceResult enrollProject(ProjectVO project) {
		ServiceResult result = ServiceResult.FAIL;
		Map<String, String> map = new HashedMap();
		map.put("project_title", project.getProj_title());
		map.put("manager_nick", project.getProjectManager().getMem_nick());
		int proj_no = projectDao.getProjCount(map);

		if (proj_no == 0) {
			int rowcnt = projectDao.insertProject(project);

			if (rowcnt == 1) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAIL;
			}
		}
		return result;
	}

	@Override
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

}
