package best.gaia.project.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository
public interface RepositoryDao {
	
	public List<Map<String, Object>> selectRepositoryList(int proj_no);

	public int insertRepository(Map<String, Object> repository);
	public int deleteRepository(Map<String, Object> repository);
}
