package best.gaia.issue.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import best.gaia.issue.dao.IssueDao;

@Service
public class IssueServiceImpl implements IssueService {
	
	@Inject
	private IssueDao dao;

}
