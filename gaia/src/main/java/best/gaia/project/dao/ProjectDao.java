package best.gaia.project.dao;


import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.ProjectVO;


@Repository
public interface ProjectDao {
	
	/**
	 * @param map
	 * 		-> manager_nick, project_title
	 * @return project number
	 */
	public Integer getProjNoByNickTitle(Map<String, Object> map);
	
	/**
	 * @param map
	 * 		-> manager_nick, project_title
	 * @return project number
	 */
	public int getProjCount(Map<String, String> map);
	
	public int insertProject(ProjectVO project);
	
}
