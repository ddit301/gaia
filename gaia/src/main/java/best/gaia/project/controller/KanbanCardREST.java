package best.gaia.project.controller;

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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.KanbanDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.KanbanCardVO;
import static best.gaia.utils.SessionUtil.*;

@RestController
@RequestMapping(value="restapi/project/kanban-cards", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class KanbanCardREST {
	
	@Inject
	private ProjectService service;
	@Inject
	private KanbanDao dao;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(KanbanCardREST.class);
	
	@GetMapping
	public List<KanbanCardVO> selectKanbanCardList(){
		return null;
	}
	
	/**
	 * @return message, kb_card_no
	 */
	@PostMapping
	public Map<String, Object> insertKanbanCard(
			@ModelAttribute KanbanCardVO card,
			Authentication authentication
			) {
		
		card.setMem_no(getMemberNoFromAuthentication(authentication));
		
		ServiceResult result = service.insertCard(card);
		logger.warn("취약점 확인을 위한 로그: {}",card.getKb_card_cont());
		
		Map<String, Object> map = new HashMap<>();
		map.put("kb_card_no", card.getKb_card_no());
		map.put("result", result);
		
		return map;
	}
	
	@PutMapping
	public Map<String, Object> updateKanbanCard(
			@ModelAttribute KanbanCardVO card
			) {
		
		ServiceResult result = dao.updateCardContent(card) == 1 ? ServiceResult.OK : ServiceResult.FAIL;
		
		Map<String, Object> map = new HashMap<>();
		map.put("card", card);
		map.put("result", result);
		return map;
	}
	
	@DeleteMapping
	public Map<String, Object> deleteKanbanCard(
			@ModelAttribute KanbanCardVO card
			) {
		ServiceResult result = service.deleteCard(card);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	
}
