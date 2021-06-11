package best.gaia.chat.dao;

import java.util.List;
import java.util.Map;

public interface ElasticChatDao {
	/**
	 * ElasticSearch 
	 */
	public int insertMessage(int mem_no, Map<String,Object> messageInfo);
	public List<Map<String, Object>> getMessageList(int mem_no);
}
