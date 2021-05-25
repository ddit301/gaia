package best.gaia.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import best.gaia.member.service.MemberService;
import best.gaia.utils.enumpkg.ServiceResult;

@Controller
public class MemberInsertController {

	@Inject
	private MemberService service;

	@RequestMapping(value="/signup/idCheck"
			, method=RequestMethod.POST
			, produces = MediaType.APPLICATION_JSON_UTF8_VALUE 
	)
	@ResponseBody
	public Map<String, Object> doPost(@RequestParam("email_id") String mem_id){
		
		Map<String, Object> resultMap = new HashMap<>();
		try {
			service.retrieveMember(mem_id);
			resultMap.put("result", ServiceResult.FAIL);
		}catch (Exception e) {
			resultMap.put("result", ServiceResult.OK);
		}
		return resultMap;
	}
}
