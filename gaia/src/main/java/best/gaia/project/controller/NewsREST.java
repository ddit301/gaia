package best.gaia.project.controller;
import static best.gaia.utils.SessionUtil.getMemberNoFromAuthentication;
import static best.gaia.utils.SessionUtil.getProjNoFromSession;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import best.gaia.project.service.ProjectService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.NewsVO;
import best.gaia.vo.PagingVO;

@RestController
@RequestMapping(value="restapi/project/news", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class NewsREST {
	
	@Inject
	private ProjectService service;
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	private static final Logger logger = LoggerFactory.getLogger(NewsREST.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public PagingVO<NewsVO> selectNewsList(
			HttpSession session
			,@ModelAttribute PagingVO<NewsVO> pagingVO
			) {
		NewsVO detailSearch = new NewsVO();
		
		detailSearch.setProj_no(getProjNoFromSession(session));
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setDataList(service.selectNewsList(pagingVO));
		
		return pagingVO;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Map<String, Object> insertNews(
			HttpSession session
			,@RequestParam("file") MultipartFile file
			,@ModelAttribute NewsVO news
			,Authentication authentication
		) throws IllegalStateException, IOException {
		
		int mem_no = getMemberNoFromAuthentication(authentication);
		int proj_no = getProjNoFromSession(session);
		news.setMem_no(mem_no);
		news.setProj_no(proj_no);
		
		// 파일이 있으면 해당 업무 진행
		if(!file.isEmpty()){
			// 파일 저장하고
			String saveFolder = "resources/images/news/" + proj_no;
			String saveFolderPath = application.getRealPath(saveFolder);
			
			// 저장한 파일명 넣기
			String fileName = getRandomFileName(file.getOriginalFilename());
			
			// 폴더 없으면 만들어주기
			new File(saveFolderPath).mkdirs();
			
			file.transferTo(new File(saveFolderPath, fileName));
			
			news.setAtch_file_sid(proj_no+"/"+fileName);
		}
		
		
		// service 호출해 그 결과 result 에 담기
		ServiceResult result = service.insertNews(news);
		
		Map<String, Object> map = new HashMap<>();
		map.put("news", news);
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Map<String, Object> updateNews() {
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public Map<String, Object> deleteNews() {
		return null;
	}
	
	String getRandomFileName(String fileName) {
		String uuid = UUID.randomUUID().toString();
		return String.format("%s_%s", uuid, fileName);
	}
	
	

}
