package best.gaia.common.service;

import java.util.List;
import java.util.Map;

public interface CommonCodeService {
	
	/**
	 * @param com_code_grp
	 * @return 특정 code_grp에 대한 com_code 와 com_code_desc 를 Map으로 반환합니다.
	 */
	public Map<String, String> getCodeMap(String com_code_grp);
	
	public List<Map<String, Object>> selectMenuList(Integer proj_no);
	
}
