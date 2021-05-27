package best.gaia.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.project.dao.NewsDao;
import best.gaia.project.dao.ProjectDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.NewsCommentVO;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Inject
	private ProjectDao dao;
	@Inject
	private NewsDao newsDao;

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

}
