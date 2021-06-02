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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.project.dao.KanbanDao;
import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.utils.exception.NotValidSessionException;
import best.gaia.vo.KanbanCardVO;
import best.gaia.vo.MemberVO;

@RestController
@RequestMapping(value="restapi/project/kanban-cards", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class KanbanCardREST {
	
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
			HttpSession session
			,@RequestParam Integer kb_col_no 
			,@RequestParam String kb_card_cont 
			,Authentication authentication
			) {
		MemberVO member = (MemberVO) authentication.getPrincipal();
		// 로그인 정보가 없을 경우 예외 처리
		if(member == null) {
			throw new NotValidSessionException();
		}
		
		// 새로운 카드 객체를 생성해서 service에 논리 로직을 태운다.
		KanbanCardVO card = new KanbanCardVO();
		card.setKb_col_no(kb_col_no);
		card.setKb_card_cont(kb_card_cont);
		card.setMem_no(member.getMem_no());
		
		ServiceResult result = service.insertKanbanCard(card);
		
		Map<String, Object> map = new HashMap<>();
		map.put("kb_card_no", card.getKb_card_no());
		map.put("result", result);
		
		return map;
	}
	
	@PutMapping
	public Map<String, Object> updateKanbanCard() {
		return null;
	}
	
	@DeleteMapping
	public Map<String, Object> deleteKanbanCard() {
		return null;
	}
	
}
