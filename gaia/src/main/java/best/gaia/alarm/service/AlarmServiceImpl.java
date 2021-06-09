package best.gaia.alarm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import best.gaia.alarm.dao.AlarmDao;
import best.gaia.common.dao.CommonCodeDao;
import best.gaia.common.service.CommonCodeService;
import best.gaia.utils.ParsingUtil;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AlarmVO;
import best.gaia.vo.CommonCodeVO;
import best.gaia.vo.IssueHistoryVO;
import best.gaia.vo.IssueVO;

@Service
public class AlarmServiceImpl implements AlarmService {
	
	@Inject
	private AlarmDao dao;
	
	@Inject
	private CommonCodeService commonService;
	@Inject
	private CommonCodeDao commonDao;

	@Override
	public ServiceResult insertIssueCommentAlarm(IssueVO issue) {
		IssueHistoryVO issueHistory = issue.getHistoryList().get(0);
		AlarmVO alarm = new AlarmVO();
		alarm.setMem_no(issue.getMem_no());
		alarm.setAlarm_type("IC");
		
		// 알램 내용을 맵으로 만들고
		Map<String, Object> alarmContent = new HashMap<>();
		alarmContent.put("url", issue.getUrl());
		alarmContent.put("proj_user_nick", issueHistory.getHistoryWriter().getMem_nick());
		alarmContent.put("issue_title",issue.getIssue_title());
		alarmContent.put("issue_his_cont",issueHistory.getIssue_his_cont());
		
		// 해당 알람 내용은 json 형태로 alarm_cont에 저장한다
		String alarm_cont = new Gson().toJson(alarmContent);
		alarm.setAlarm_cont(alarm_cont);

		int result = dao.insertAlarm(alarm);
		
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
			alarm.setUrl(alarmData.get("url").toString());
			
		}
		
		// 데이터 가공이 끝난 Alarm 리스트를 반환합니다.
		return list;
	}

	@Override
	public int updateUnreadAlarms(int mem_no) {
		return dao.updateUnreadAlarms(mem_no);
	}

}
