package best.gaia.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.KanbanDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.KanbanCardVO;

@RestController
public class KanbanCardController {
	
	@Inject
	private ProjectService service;
	@Inject
	private KanbanDao kanbanDao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(KanbanCardController.class);
	
	@ResponseBody
	@RequestMapping("/restapi/project/kanban/moveCard.do")
	public Map<String, Object> moveCard(
				@RequestParam Integer droppedCardNo
				,@RequestParam Integer newColumnNo
				,@RequestParam(required = false) Integer nextCardNo
			) {
		
		ServiceResult result = service.moveCard(droppedCardNo, newColumnNo, nextCardNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result",result);
		return map;

	}
	
	

}
