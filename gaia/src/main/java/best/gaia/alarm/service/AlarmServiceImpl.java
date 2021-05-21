package best.gaia.alarm.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.alarm.dao.AlarmDao;

@Service
public class AlarmServiceImpl implements AlarmService {
	
	@Inject
	private AlarmDao dao;

}
