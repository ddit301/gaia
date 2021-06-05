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
	public Integer getProjNoByNickTitle(Map<String,Object> map);
	/**
	 * @param map
	 * 		-> proj_no, mem_no
	 * @return
	 */
	public String getProjectNickNameByMemNo(Map<String, Object>map);
	
}
