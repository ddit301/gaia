package best.gaia.chat.service;

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
		// participant1, participant2와 비교. 1은 self
		int result = ordao.exists(participants);
		return result;
	}
	@Override
	public ServiceResult insertChatRoom(ChatRoomVO roomInfo) {
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

	
	@Transactional
	public ServiceResult createChatRoom(ChatRoomVO roomInfo, 
				Map<String, Object> participant1, Map<String, Object> participant2) {
		// 최초 방 생성 시.(기본적으로 1:1채팅)
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
