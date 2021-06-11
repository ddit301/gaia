package best.gaia.alarm.controller;

import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.alarm.dao.AlarmDao;
import best.gaia.alarm.service.AlarmService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.AlarmVO;

@RestController
@RequestMapping(value="restapi/alarm/alarms", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class AlarmREST {
	
	@Inject
	private AlarmService service;
	@Inject
	private AlarmDao dao;

	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(AlarmREST.class);
	
	@GetMapping
	public List<AlarmVO> alarmList(
			Authentication authentication
			) {
		// authentication에서 mem_no를 받아온다.
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		// 알람 로직을 쭉 태운 뒤에 가공된 알람을 보낸다
		return service.selectAlarmList(mem_no);
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertAlarm() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Integer updateAlarm(
			Authentication authentication
			) {
		// authentication에서 mem_no를 받아온다.
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		// 안 읽은 모든 알람을 현 시간에 읽은 것으로 업데이트 시키고, 업데이트 된 갯수를 반환한다.
		return service.updateUnreadAlarms(mem_no);
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Integer deleteAlarm(
			Authentication authentication
			) {
		// authentication에서 mem_no를 받아온다.
		int mem_no = getMemberNoFromAuthentication(authentication);
		
		// 회원의 모든 읽은 알람을 데이터베이스에서 삭제한다.
		return dao.deleteReadAlarms(mem_no);
	}

}






