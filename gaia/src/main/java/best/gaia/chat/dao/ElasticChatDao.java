package best.gaia.chat.dao;

import java.util.List;
import java.util.Map;

public interface ElasticChatDao {
	/**
	 * ElasticSearch 
	 */
	public int insertMessage(int mem_no, Map<String,Object> messageInfo);
	// 해당 맴버의 모든 채팅 들고오기.
	public List<Map<String, Object>> getMessageList(int mem_no);
	// 해당 방의 모든 채팅 들고오기. 
	public List<Map<String, Object>> getMessageListbyChatRoom(int chatRoom_no);
	
	public List<Map<String, Object>> getMessageListbyChatRoomOne(int chatRoom_no, int size);
}
