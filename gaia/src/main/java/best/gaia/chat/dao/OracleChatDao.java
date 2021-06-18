package best.gaia.chat.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import best.gaia.vo.ChatRoomVO;
import best.gaia.vo.MemberVO;

@Repository
public interface OracleChatDao {
	
	/**
	 * Oracle
	 */
	public List<ChatRoomVO> selectMemberChatRoomList(int mem_no);
	public List<MemberVO> searchMemberList(Map<String, Object> searchInfo);
	public int insertChatRoom(ChatRoomVO roomInfo);
	public int insertChatRoomMember(Map<String, Object> participants);
	public int exists(Map<String, Object> participants);
	public List<MemberVO> memberListByChatRoom(int chatRoom_no);
}
