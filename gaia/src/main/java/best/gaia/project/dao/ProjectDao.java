package best.gaia.project.dao;


import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.ProjectVO;


@Repository
public interface ProjectDao {
	
	/**
	 * @param map
	 * 		-> manager_id, project_title
	 * @return project number
	 */
	public Integer getProjNoFromIdAndTitle(Map<String, Object> map);
	
	/**
	 * @param map
	 * 		-> proj_no, mem_no
	 * @return
	 */
	public String getProjectNickNameByMemNo(Map<String, Object>map);

	/**
	 * @param map
	 * 		-> manager_id, project_title
	 * @return project number
	 */
	public int getProjCount(Map<String, String> map);
	
	public int insertProject(ProjectVO project);
	
}
