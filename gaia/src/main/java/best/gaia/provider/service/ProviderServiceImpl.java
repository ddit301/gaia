package best.gaia.provider.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import best.gaia.provider.dao.ProviderDao;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;
import best.gaia.vo.ProviderVO;

@Service
public class ProviderServiceImpl implements ProviderService {

	@Inject
	private ProviderDao dao;
	private static final Logger logger = LoggerFactory.getLogger(ProviderServiceImpl.class);

	@Inject
	private PasswordEncoder passwordEncoder;
	
	
	@Override
	public ProviderVO retrieveProvider(String prov_id) {
		ProviderVO savedProvider = dao.selectProviderForAuth(prov_id);
		if (savedProvider == null) {
			throw new RuntimeException("해당 이메일을 등록한 회원이 존재하지 않음.");
		}
		return savedProvider;
	}
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
