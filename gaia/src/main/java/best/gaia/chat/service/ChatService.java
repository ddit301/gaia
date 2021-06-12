package best.gaia.chat.service;

import java.util.List;
import java.util.Map;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ChatVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.MemberVO;

public interface ChatService {
	/**
	 *  ElasticSearch 
	 */
	public ServiceResult insertMemberMessage(int mem_no, Map<String, Object> chat);
	public List<Map<String, Object>> getMemberMessage(int mem_no);
	
	/**
	 *  Oracle
	 */
	public List<ChatVO> selectMemberChatRoomList(int mem_no);
	public ServiceResult insertChatRoom(Map<String, Object> roomInfo);
	public ServiceResult insertChatRoomMember(Map<String, Object> participants);
	public List<Map<String, Object>>  exists(int mem_no);
}
