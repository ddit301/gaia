package best.gaia.project.dao;


import java.util.List;
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
	
	/**
	 * @param mem_no
	 * @return 특정 회원이 속한 모든 프로젝트 목록을 불러옵니다.
	 * mem_no가 null 일 경우 서비스상 존재하는 모든 프로젝트 목록을 불러옵니다.
	 */
	public List<ProjectVO> selectProjectList(Integer mem_no);
	
}
