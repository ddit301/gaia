package best.gaia.chat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.chat.dao.ElasticChatDao;
import best.gaia.chat.dao.OracleChatDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ChatRoomVO;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.MemberVO;

// elastic 연결하기 전처리.(최초의 처리)
@Service
public class ChatServiceImpl implements ChatService{
	
	@Inject
	private ElasticChatDao eldao;
	@Inject
	private OracleChatDao ordao;
	
	
	/**
	 *  ElasticSearch 
	 */
	@Override
	public ServiceResult insertElasticMessage(int mem_no, Map<String, Object> chat) {
		int result = eldao.insertMessage(mem_no, chat);
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
	} 
	@Override
	public List<Map<String, Object>> getMemberMessage(int mem_no) {
		return eldao.getMessageList(mem_no);
	}
	
	@Override
	public List<Map<String, Object>> getMessageListbyChatRoom(int chatRoom_no) {
		// 해당 방의 채팅 리스트 들고오기.
		return eldao.getMessageListbyChatRoom(chatRoom_no);
	}
	@Override
	public List<Map<String, Object>> getMessageListbyChatRoomOne(int chatRoom_no, int size) {
		// 해당 방의 가장 최근 채팅 들고오기.
		return eldao.getMessageListbyChatRoomOne(chatRoom_no, size);
	}
	
	
	
	/*
	 * Oracle 
	 */
 	@Override
	public List<ChatRoomVO> selectMemberChatRoomList(int mem_no) {
 		List<ChatRoomVO> roomList = ordao.selectMemberChatRoomList(mem_no);
		return roomList;
	}
	@Override
	public List<MemberVO> searchMemberList(Map<String, Object> searchInfo) {
		List<MemberVO> memberList = ordao.searchMemberList(searchInfo);
		return memberList;
	}
	@Override
	public int exists(Map<String, Object> participants) {
		// mem_no1, mem_no2와 비교. 1은 self
		int result = ordao.exists(participants);
		return result;
	}
	// 초대 시에만 가능.
	@Override
	public ServiceResult insertChatRoomMember(Map<String, Object> participants) {
		// mem_no, chatroom_no
		int result = ordao.insertChatRoomMember(participants);
		return result == 1? ServiceResult.OK : ServiceResult.FAIL;
	}

	
	// 최초 방 생성 시.(기본적으로 1:1채팅)
	@Override
	@Transactional
	public ServiceResult createChatRoom(ChatRoomVO roomInfo, 
				Map<String, Object> mem_nos) {
		int result = ordao.insertChatRoom(roomInfo);
		if(result == 1) {
			// 오직 처음에 만들어 질 때 상대방과 내가 해당 채팅방의 맴버가 됨.
			// 이후부터는 service.insertChatRoomMember가 호출됨.
			Map<String, Object> participant1 =new HashMap<>();
			Map<String, Object> participant2 =new HashMap<>();
			
			participant1.put("mem_no", mem_nos.get("mem_no1"));
			participant1.put("chatroom_no", roomInfo.getChatroom_no());
			
			participant2.put("mem_no", mem_nos.get("mem_no2"));
			participant2.put("chatroom_no", roomInfo.getChatroom_no());
			
			result *= ordao.insertChatRoomMember(participant1);
			result *= ordao.insertChatRoomMember(participant2);
			
			Map<String, Object> chat = new HashMap<String, Object>();
			chat.put("content", "");
			chat.put("chatroom_no",roomInfo.getChatroom_no());
			result *= eldao.insertMessage((int)mem_nos.get("mem_no1"), chat);
		}
		return result == 1? ServiceResult.OK : ServiceResult.FAIL;
	}
	@Override
	public List<MemberVO> memberListByChatRoom(int chatRoom_no) {
		return ordao.memberListByChatRoom(chatRoom_no);
	}
}
