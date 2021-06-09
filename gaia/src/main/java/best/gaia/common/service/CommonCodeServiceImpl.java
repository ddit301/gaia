package best.gaia.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.common.dao.CommonCodeDao;
import best.gaia.vo.CommonCodeVO;

@Service
public class CommonCodeServiceImpl implements CommonCodeService {
	
	@Inject
	private CommonCodeDao dao;

	@Override
	public Map<String, String> getCodeMap(String com_code_grp) {
		List<CommonCodeVO> codeList = dao.selectCodesByGroup("AT");
		Map<String, String> codeMap = new HashMap<>();
		for(CommonCodeVO vo : codeList) {
			codeMap.put(vo.getCom_code(), vo.getCom_code_desc());
		}
		return codeMap;
	}


}
