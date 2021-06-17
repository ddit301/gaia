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
	public ServiceResult insertElasticMessage(MemberVO mem, Map<String, Object> chat);
	public List<Map<String, Object>> getMemberMessage(int mem_no);
	public List<Map<String, Object>> getMessageListbyChatRoom(int mem_no);
	public List<Map<String, Object>> getMessageListbyChatRoomOne(int chatroom_no, int size);
	
	
	/**
	 *  Oracle
	 */
	public List<ChatRoomVO> selectMemberChatRoomList(int mem_no);
	/**
	 * 본인을 제외한 모든 회원들 조회.
	 * @param mem_no
	 * @return List<MemberVO>
	 */
	public List<MemberVO> searchMemberList(Map<String, Object> searchInfo);
	public ServiceResult insertChatRoom(ChatRoomVO roomInfo);
	public ServiceResult insertChatRoomMember(Map<String, Object> participants);
	public int exists(Map<String, Object> participants);
}
