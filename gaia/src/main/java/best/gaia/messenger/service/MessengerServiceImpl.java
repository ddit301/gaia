package best.gaia.messenger.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.messenger.dao.MessengerDao;

@Service
public class MessengerServiceImpl implements MessengerService {
	
	@Inject
	private MessengerDao dao;

}
