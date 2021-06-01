package best.gaia.provider.service;

import best.gaia.vo.ProviderVO;

public interface ProviderService {

	/**
	 * 회원 정보 상세 조회
	 * 
	 * @param mem_id
	 * @return 존재하지 않으면, custom exception 발생
	 */
	public ProviderVO retrieveProvider(String prov_id);

}
