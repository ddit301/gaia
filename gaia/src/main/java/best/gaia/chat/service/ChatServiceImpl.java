package best.gaia.chat.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import best.gaia.chat.dao.ElasticChatDao;
import best.gaia.chat.dao.OracleChatDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.ChatVO;
import best.gaia.vo.IssueHistoryVO;

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
	public ServiceResult insertMemberMessage(int mem_no, Map<String, Object> message) {
		message.put("room", 1);
		message.put("content", "hi");
		int result = eldao.insertMessage(mem_no, message);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	@Override
	public List<Map<String, Object>> getMemberMessage(int mem_no) {
		return eldao.getMessageList(mem_no);
	}
	
	/*
	 * Oracle 
	 */
 	@Override
	public List<ChatVO> selectMemberChatRoomList(int mem_no) {
 		List<ChatVO> roomList = ordao.selectMemberChatRoomList(mem_no);
		if (roomList == null) {
			throw new RuntimeException("해당 회원이 속해있는 대화방이 존재하지 않음.");
		}
		return roomList;
	}
	@Override
	public List<Map<String, Object>> exists(int mem_no) {
		List<Map<String, Object>> result = ordao.exists(mem_no);
		
		return result;
	}
	@Override
	public ServiceResult insertChatRoom(Map<String, Object> roomInfo) {
		// chatroom_no, chatroom_title, chatroom_create_date, chatroom_alarm
		int result = ordao.insertChatRoom(roomInfo);
		return result == 1? ServiceResult.OK : ServiceResult.FAIL; 
	}
	// 초대 시에만 가능.
	@Override
	public ServiceResult insertChatRoomMember(Map<String, Object> participants) {
		// mem_no, chatroom_no
		int result = ordao.insertChatRoomMember(participants);
		return result == 1? ServiceResult.OK : ServiceResult.FAIL;
	}
	// 최초 방 생성 시.(기본적으로 1:1채팅)
	@Transactional
	public ServiceResult createChatRoom(Map<String, Object> roomInfo, 
				Map<String, Object> participant1, Map<String, Object> participant2) {
		// 채팅방 개설
		int result = ordao.insertChatRoom(roomInfo);
		if(result == 1) {
			// 오직 처음에 만들어 질 때 상대방과 내가 해당 채팅방의 맴버가 됨.
			// 이후부터는 service.insertChatRoomMember가 호출됨.
			result *= ordao.insertChatRoomMember(participant1);
			result *= ordao.insertChatRoomMember(participant2);
		}
		return result == 1? ServiceResult.OK : ServiceResult.FAIL;
	}
	// 채팅 시 
	@Transactional
	public ServiceResult Messaging(int participant1, int participant2) {
		// 상대와 나의 대화방이 존재한다면 해당 대화방을return.
		
		// 상대와 나의 대화방이 존재하지 않다면 새로운 대화방 생성.
//		createChatRoom(Map<String, Object> roomInfo, 
//				Map<String, Object> participant1, Map<String, Object> participant2);
		
		return null;
	}
	
}
