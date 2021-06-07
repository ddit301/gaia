package best.gaia.alarm.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.alarm.service.AlarmService;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/alarm/alarms", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class AlarmREST {
	
	@Inject
	private AlarmService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(AlarmREST.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public Map<String, Object> selectAlarmList() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertAlarm() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateAlarm() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteAlarm() {
		return null;
	}

}
