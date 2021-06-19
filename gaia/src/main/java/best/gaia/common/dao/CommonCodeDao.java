package best.gaia.common.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.CommonCodeVO;


@Repository
public interface CommonCodeDao {
	
	public List<CommonCodeVO> selectCodesByGroup(String com_code_grp);
	public List<Map<String, Object>> selectMenuList();
	
}
