package best.gaia.chat.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.IssueVO;

@Repository
public interface OracleChatDao {
	
	/**
	 * Oracle
	 */
	public List<Map<String, Object>> selectMemberChatRoomList(int mem_no);
	public int insertChatRoom(Map<String, Object> roomInfo);
	public int insertChatRoomMember(Map<String, Object> participants);
	public List<Map<String, Object>> exists(int mem_no);
}