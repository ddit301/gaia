package best.gaia.utils;

import java.util.Map;
import java.util.Set;

/**
 * @author Shane
 * @since 9 Jun 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 9 Jun 2021  Shane    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 */
public class ParsingUtil {
	
	/**
	 * Map 으로 data를 받아 result에 있는 #{} place holder 자리에 데이터를 넣어주는 메서드 입니다.
	 * @param data
	 * @param result
	 * @return
	 */
	public static String elMapper(Map<String,String> data, String result ) {
		Set<String> keySet = data.keySet();
		for(String key : keySet) {
			result = result.replace(
					String.format("%s%s%s", "#{",key,"}")
					, data.get(key));
		}
		return result;
	}
	
}
