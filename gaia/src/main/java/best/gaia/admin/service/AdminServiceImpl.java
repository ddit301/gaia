package best.gaia.admin.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.admin.dao.AdminDao;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Inject
	private AdminDao dao;

}
