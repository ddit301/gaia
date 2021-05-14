package best.gaia.project.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.project.dao.ProjectDao;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Inject
	private ProjectDao dao;

}
