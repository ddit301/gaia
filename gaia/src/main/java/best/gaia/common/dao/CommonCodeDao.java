package best.gaia.common.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.CommonCodeVO;
import best.gaia.vo.MenuVO;


@Repository
public interface CommonCodeDao {
	
	public List<CommonCodeVO> selectCodesByGroup(String com_code_grp);
	public List<MenuVO> selectMenuList();
	
}
