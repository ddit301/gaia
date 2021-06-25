package best.gaia.chat.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.elasticsearch.search.sort.SortOrder;
import org.springframework.stereotype.Component;

import best.gaia.utils.ElasticUtil;

@Component
public class ElasticChatDaoImpl implements ElasticChatDao {
	@Inject
	private ElasticUtil elastic;

	@Override
	public int insertMessage(int mem_no, Map<String, Object> chat) {
		chat.put("mem_no", mem_no);
		String index = "message";
		return elastic.insert(index, chat);
	}
	@Override
	public List<Map<String, Object>> getMessageList(int mem_no) {
		String index = "message";

		Map<String, Object> query = new HashMap<>();
		query.put("mem_no", mem_no);
		query.put("chatroom_no", mem_no);

		Map<String, SortOrder> sort = new HashMap<>();
		sort.put("date", SortOrder.DESC);

		return elastic.simpleSearch(index, query, sort, null);
	}
	
	@Override
	public List<Map<String, Object>> getMessageListbyChatRoom(int chatroom_no) {
		String index = "message";
		
		Map<String, Object> query = new HashMap<>();
		query.put("chatroom_no", chatroom_no);
		
		Map<String, SortOrder> sort = new HashMap<>();
		sort.put("date", SortOrder.DESC);
		
		return elastic.simpleSearch(index, query, sort, null);
	}
	@Override
	public List<Map<String, Object>> getMessageListbyChatRoomOne(int chatRoom_no, int size) {
		String index = "message";
		
		Map<String, Object> query = new HashMap<>();
		query.put("chatroom_no", chatRoom_no);
		
		Map<String, SortOrder> sort = new HashMap<>();
		sort.put("date", SortOrder.DESC);
		
		return elastic.simpleSearch(index, query, sort, size);
	}
	

	
	/**
	 *  통합 검색 용!!
	 */
	@Override
	public List<Map<String, Object>> getTotalSearchResult(String keyword) {
		
		Map<String, Object> query = new HashMap<>();
		query.put("_all", keyword);
		
		Map<String, SortOrder> sort = new HashMap<>();
		sort.put("date", SortOrder.DESC);
		
		return elastic.totalSearch("");
	}
}
