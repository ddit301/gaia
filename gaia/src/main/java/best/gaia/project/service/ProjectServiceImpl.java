package best.gaia.project.service;

import java.util.List;

import javax.inject.Inject;

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

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Inject
	private ProjectDao dao;
	@Inject
	private NewsDao newsDao;
	@Inject
	private KanbanDao kanbanDao;

	@Override
	public List<NewsVO> selectNewsList(PagingVO<NewsVO> pagingVO) {
		return newsDao.selectNewsList(pagingVO);
	}

	@Override
	public ServiceResult insertNews(NewsVO news) {
		// TODO Auto-generated method stub
		return null;
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
		if(droppedCard.getKb_card_next_no() != null) {
			previousNextCard = kanbanDao.selectCard(droppedCard.getKb_card_next_no());
		}
		// 드랍된 카드의 현재 다음 카드 정보
		if(nextCardNo != null) {
			currentNextCard = kanbanDao.selectCard(nextCardNo);
		}
		
		
		if(previousNextCard != null) {
			// previousNextCard가 droppedCard의 priv_no를 priv_no 로 가진다.
			previousNextCard.setKb_card_priv_no(droppedCard.getKb_card_priv_no());
		}
		
		// droppedCard의 이전 카드 정보를 현재 다음 카드의 이전 카드 넘버에서 가져와 수정한다.
		if(currentNextCard == null) {
			// 새로운 자리에 다음 카드가 없다면, 이사 온 컬럼의 마지막 카드를 priv_no 로 갖는다.
			Integer lastCardNo = kanbanDao.getLastCardNo(newColumnNo);
			droppedCard.setKb_card_priv_no(lastCardNo);
		}else {
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
		if(previousNextCard != null) {
			validChecker *= kanbanDao.updateCard(previousNextCard);
		}
		validChecker *= kanbanDao.updateCard(droppedCard);
		if(currentNextCard != null) {
			validChecker *= kanbanDao.updateCard(currentNextCard);
		}
		
		if(validChecker == 1) {
			return ServiceResult.OK;
		}else {
			return ServiceResult.FAIL;
		}
	}

}
