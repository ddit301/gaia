package best.gaia.project.controller;

import static best.gaia.utils.SessionUtil.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import best.gaia.project.dao.ProjectDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemRoleVO;

@RestController
@RequestMapping(value="restapi/project/roles", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberRoleRest {
	
	@Inject
	private ProjectService service;
	@Inject
	private ProjectDao dao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(MemberRoleRest.class);
	
	@GetMapping
	public List<Map<String, Object>> selectMemRoleList(
			HttpSession session
			) {
		int proj_no = getProjNoFromSession(session);
		return dao.selectMemRoleList(proj_no);
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public Map<String, Object> insertAndUpdateMemroles(
			HttpSession session
			,@RequestParam String editRolesData
			,@RequestParam String newRolesData
			) {
		Gson gson = new Gson();
		List<MemRoleVO> editRoles = 
				gson.fromJson(editRolesData, new TypeToken<ArrayList<MemRoleVO>>(){}.getType());
		
		List<MemRoleVO> newRoles = 
				gson.fromJson(newRolesData, new TypeToken<ArrayList<MemRoleVO>>(){}.getType());

		int proj_no = getProjNoFromSession(session);
		ServiceResult result = service.insertAndUpdateMemroles(proj_no, newRoles, editRoles);
		int newCount = newRoles.size();
		int editCount = editRoles.size();
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("result",result);
		resultMap.put("newCount",newCount);
		resultMap.put("editCount",editCount);
		
		return resultMap;
		
	}
	
	@RequestMapping(method = RequestMethod.DELETE)
	public ServiceResult deleteMemrole(
			@RequestParam int mem_role_no
			) {
		int result = dao.deleteMemberRole(mem_role_no);
		
		return result==1 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
}
