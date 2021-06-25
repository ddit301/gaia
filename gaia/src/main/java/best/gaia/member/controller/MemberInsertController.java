package best.gaia.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import best.gaia.member.service.MemberService;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

@Controller
public class MemberInsertController {

	private static final Logger logger = LoggerFactory.getLogger(MemberInsertController.class);
	@Inject
	private MemberService service;

	@RequestMapping(value = "/signup/idCheck", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> doPost(@RequestParam("mem_id") String mem_id) {

		Map<String, Object> resultMap = new HashMap<>();
		try {
			int count = service.retrieveMember(mem_id);
			if (count == 0) {
				resultMap.put("result", ServiceResult.OK);
			} else {
				resultMap.put("result", ServiceResult.FAIL);
			}
		} catch (Exception e) {
			resultMap.put("result", ServiceResult.FAIL);
		}
		return resultMap;
	}

	@RequestMapping(value = "/signup/register"
			, method = RequestMethod.POST
			, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult process(@ModelAttribute("member") MemberVO member, BindingResult errors, Model model) {
		
		ServiceResult result = ServiceResult.FAIL;
		
		if (!errors.hasErrors()) {
			result = service.enrollMember(member);
		}

		return result;
	}

}
