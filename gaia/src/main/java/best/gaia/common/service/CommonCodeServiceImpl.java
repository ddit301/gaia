package best.gaia.common.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.math.NumberUtils;
import org.springframework.stereotype.Service;

import best.gaia.common.dao.CommonCodeDao;
import best.gaia.project.dao.ProjectDao;
import best.gaia.vo.CommonCodeVO;
import best.gaia.vo.ProjectVO;

@Service
public class CommonCodeServiceImpl implements CommonCodeService {
	
	@Inject
	private CommonCodeDao dao;
	
	@Inject
	private ProjectDao projDao;

	@Override
	public Map<String, String> getCodeMap(String com_code_grp) {
		List<CommonCodeVO> codeList = dao.selectCodesByGroup("AT");
		Map<String, String> codeMap = new HashMap<>();
		for(CommonCodeVO vo : codeList) {
			codeMap.put(vo.getCom_code(), vo.getCom_code_desc());
		}
		return codeMap;
	}

	@Override
	public List<Map<String, Object>> selectMenuList(Integer proj_no) {
		
		// 1. 모든 메뉴 리스트 받아 온 후
		List<Map<String, Object>> menuList = dao.selectMenuList();
		
		// 프로젝트가 아직 결정되지 않은 상태라면 모든 메뉴를 다 반환한다.
		if(proj_no == null)
			return menuList;
		
		// 2. 해당 proj_no 에서 사용중인 모듈 설정 불러와서
		ProjectVO project = projDao.selectProject(proj_no);
		int proj_module_set = project.getProj_module_set();
		String moduleSetting = integerToBinary(proj_module_set, 8);
		
		// 3. 사용 안하는 모듈들 메뉴에서 찾기
		int size = menuList.size();
		
		int count = 0;	// list에서 제거할 것 이기 떄문에, 제거하면서 사이즈가 작아진다.
		for(int i=0; i<size; i++) {
			Map<String, Object> menu = menuList.get(i-count);
			Object menuSetIndex = menu.get("MENU_SET_INDEX");
			
			// 4. 메뉴 셋 index에 들어있는 값이 있고, 숫자일 경우에만 검사한다.
			if(menuSetIndex != null && NumberUtils.isNumber(menuSetIndex.toString())) {
				int checker = Integer.parseInt(menuSetIndex.toString());
				// 5. 사용 안함으로 설정된 모듈은 메뉴에서 제거해주기 위해 목록에 추가해둔다.
				if('0' == moduleSetting.charAt(checker)) {
					menuList.remove(i-count++);
				}
			}
		}
		
		// 6. 걸러진 메뉴 리스트를 반환한다.
		return menuList;
	}
	
	// number를 length 에 맞는 binary String으로 출력해주는 메서드
	public String integerToBinary(int number, int length) {
		StringBuilder binary = new StringBuilder(Integer.toBinaryString(number));
		int size = binary.length();
		for(int i=size; i<length; i++) {
			binary.insert(0,"0");
		}
		return binary.toString();
	}


}
