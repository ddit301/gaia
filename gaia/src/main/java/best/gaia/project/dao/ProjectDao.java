package best.gaia.project.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface ProjectDao {
	
	/**
	 * 프로젝트 생성자 닉네임과 프로젝트 이름으로 프로젝트 번호를 알아내는 함수입니다.
	 * @param manager_nick
	 * @param project_title
	 * @return
	 */
	public int searchProjNumber(Map<String, String> map);
}
