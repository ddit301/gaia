package best.gaia.alarm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import best.gaia.alarm.dao.AlarmDao;
import best.gaia.common.dao.CommonCodeDao;
import best.gaia.common.service.CommonCodeService;
import best.gaia.member.dao.MemberDao;
import best.gaia.utils.ParsingUtil;
import best.gaia.utils.components.WebSocketComponent;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AlarmVO;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;
import best.gaia.vo.ProjectVO;

@Service
public class AlarmServiceImpl implements AlarmService {
	
	@Inject
	private AlarmDao dao;
	@Inject
	private MemberDao memDao;
	
	@Inject
	private CommonCodeService commonService;
	
	@Inject
	private CommonCodeDao commonDao;
	
	@Inject
	private WebSocketComponent webSocket;
	
	@Override
	public ServiceResult insertInviteAlarm(Map<String, Object> inviteInfo) {
		AlarmVO alarm = new AlarmVO();
		int receiverNo = Integer.parseInt(inviteInfo.get("receiverNo").toString());
		int ownerNo = Integer.parseInt(inviteInfo.get("ownerNo").toString());
		String proj_title = inviteInfo.get("proj_title").toString();
		alarm.setMem_no(receiverNo);
		String alarm_type = "PJ";
		alarm.setAlarm_type(alarm_type);
		alarm.setSender_no(ownerNo);
		
		// 알람 내용을 맵으로 만들기
		Map<String, String> alarmContent = new HashMap<>();
		alarmContent.put("proj_title", proj_title);
		
		// 해당 알람 내용은 json 형태로 alarm_cont에 저장한다
		String alarm_cont = new Gson().toJson(alarmContent);
		alarm.setAlarm_cont(alarm_cont);
		
		int result = dao.insertAlarm(alarm);
		
		// 알람 전송에 성공했으면, 세션에 해당 유저가 접속중일 경우 websocket을 통해 push 알림을 보낸다.
		Map<String, Object> dataMap = new HashMap<>();
		
		String manager_id = memDao.getMemIdFromMemNo(ownerNo);
		dataMap.put("type", "PJ");
		dataMap.put("manager_id",manager_id);
		dataMap.put("project_title", proj_title);
		
		String data = new Gson().toJson(dataMap);
		
		webSocket.sendPushNotificationToMember(receiverNo, alarm_type, data);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
		
	}
	
	@Override
	@Transactional
	public ServiceResult insertIssueCommentAlarm(IssueVO issue) {
		IssueHistoryVO issueHistory = issue.getHistoryList().get(0);
		AlarmVO alarm = new AlarmVO();
		alarm.setMem_no(issue.getMem_no());
		String alarm_type = "IC";
		alarm.setAlarm_type(alarm_type);
		alarm.setSender_no(issueHistory.getMem_no());
		
		// 알램 내용을 맵으로 만들고
		Map<String, String> alarmContent = new HashMap<>();
		alarmContent.put("url", issue.getUrl());
		String proj_user_nick = issueHistory.getHistoryWriter().getMem_nick();
		alarmContent.put("proj_user_nick", proj_user_nick);
		alarmContent.put("issue_title",issue.getIssue_title());
		alarmContent.put("issue_his_cont",issueHistory.getIssue_his_cont());
		
		// 해당 알람 내용은 json 형태로 alarm_cont에 저장한다
		String alarm_cont = new Gson().toJson(alarmContent);
		alarm.setAlarm_cont(alarm_cont);

		int result = dao.insertAlarm(alarm);
		
		// 알람 전송에 성공했으면, 세션에 해당 유저가 접속중일 경우 websocket을 통해 push 알림을 보낸다.
		webSocket.sendPushNotificationToMember(issue.getMem_no(),alarm_type,proj_user_nick);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<AlarmVO> selectAlarmList(int mem_no) {
		
		// 일단 회원에게 해당하는 alarm 데이터들을 불러 옵니다.
		List<AlarmVO> list = dao.getAlarmList(mem_no);
		
		// 알람 데이터 가공을 위해 알람 타입에 해당하는 codeMap 을 받아옵니다.
		Map<String, String> codeMap = commonService.getCodeMap("AT");
		
		// alarm list를 하나하나 반복문 돌려가며 가공합니다.
		for(AlarmVO alarm : list) {
			// 알람 cont에 json 형태로 담아둔 데이터를 Map으로 꺼내옵니다.
			Map<String,String> alarmData = new Gson().fromJson(alarm.getAlarm_cont(), Map.class);
			
			// 해당 알람의 type에 해당하는 com_code_desc를 받아 옵니다.
			String com_code_desc = codeMap.get(alarm.getAlarm_type());
			
			// alarm_cont 에 출력해줄 알람 데이터를 만들어 줍니다.
			String alarm_cont = ParsingUtil.elMapper(alarmData, com_code_desc);
			alarm.setAlarm_cont(alarm_cont);
			
			// 마지막으로 alarm_cont에 url이 있다면, 담아서 보내줍니다. 
			if(alarmData.containsKey("url")) {
				alarm.setUrl(alarmData.get("url").toString());
			}
			
		}
		
		// 데이터 가공이 끝난 Alarm 리스트를 반환합니다.
		return list;
	}

	@Override
	public int updateUnreadAlarms(int mem_no) {
		return dao.updateUnreadAlarms(mem_no);
	}


}
