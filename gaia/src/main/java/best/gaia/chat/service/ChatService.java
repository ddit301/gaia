package best.gaia.chat.service;

import java.util.List;
import java.util.Map;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ChatRoomVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

public interface ChatService {
	/**
	 *  ElasticSearch 
	 */
	public ServiceResult insertMemberMessage(int chatroom_no, Map<String, Object> chat);
	public List<Map<String, Object>> getMemberMessage(int mem_no);
	public List<Map<String, Object>> getMessageListbyChatRoom(int mem_no);
	public List<Map<String, Object>> getMessageListbyChatRoomOne(int chatroom_no, int size);
	
	
	/**
	 *  Oracle
	 */
	public List<ChatRoomVO> selectMemberChatRoomList(int mem_no);
	public ServiceResult insertChatRoom(Map<String, Object> roomInfo);
	public ServiceResult insertChatRoomMember(Map<String, Object> participants);
	public List<Map<String, Object>>  exists(int mem_no);
}
