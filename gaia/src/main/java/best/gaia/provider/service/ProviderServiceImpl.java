package best.gaia.provider.service;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import best.gaia.provider.dao.ProviderDao;
import best.gaia.vo.ProviderVO;

@Service
public class ProviderServiceImpl implements ProviderService {

	@Inject
	private ProviderDao dao;
//	@Inject
//	private AuthenticateService authService;

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

}
