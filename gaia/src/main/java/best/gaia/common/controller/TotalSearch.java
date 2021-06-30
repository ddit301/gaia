package best.gaia.common.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import best.gaia.project.controller.ProjectREST;
import best.gaia.utils.ElasticUtil;

@RestController
public class TotalSearch {
	
	@Inject
	private ElasticUtil elUtil;
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectREST.class);

	
	
	// totalSearch
	@GetMapping(value="restapi/common/totalsearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String selectKewordResult(
					Authentication authentication
					, @RequestParam String need
					, @RequestParam Map<String, Object> map
					) throws IOException {
		String keyword = (String) map.get("keyword");
		
		
		String url = String.format("http://%s:%d/gaia/_search?scroll=10m&size=20&q=%s",elUtil.getHostname(),elUtil.getPort(),keyword);
		String text = getRequestApiGet(url);
		
		logger.info(text);
		return text;
	}
	
	public String getRequestApiGet(String url) throws IOException {
		URL obj = new URL(url);
		
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		// optional default is GET
		con.setRequestMethod("GET");
		
		// add request header 헤더를 만드는
		con.setRequestProperty("Accept-Chatset", "UTF-8");
		con.setRequestProperty("Content-Type", "application/json; charset=utf-8");
		
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
		String inputLine;
		String resultXmlText = "";
		while((inputLine = in.readLine()) != null) {
			resultXmlText += inputLine;
		}
		in.close();
		con.disconnect();
		return resultXmlText;
	}
}
