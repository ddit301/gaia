package best.gaia.alarm.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.CommonCodeVO;


@Repository
public interface CommonCodeDao {
	
	public List<CommonCodeVO> selectCodesByGroup(String com_code_grp);
	
}
