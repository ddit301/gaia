package best.gaia.admin.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import best.gaia.admin.dao.AdminDao;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDao dao;
	private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);

	@Override
	public List<MemberVO> retrieveAllMember() {
		return dao.selectAllMemberList();
	}
	@Override
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO) {
		return dao.selectMemberCount(pagingVO);
	}

	@Override
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO) {
		return dao.selectMemberList(pagingVO);
	}

}
