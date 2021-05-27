package best.gaia.project.dao;


import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository
public interface ProjectDao {
	
	/**
	 * @param map
	 * 		-> manager_nick, project_title
	 * @return project number
	 */
	public Integer getProjNoWithMngNickkAndPrjTitle(Map<String,Object> map);
	
}
