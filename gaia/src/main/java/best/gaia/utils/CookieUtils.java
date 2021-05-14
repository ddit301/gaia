package best.gaia.utils;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieUtils {
	Map<String, Cookie> cookieMap;
	private HttpServletRequest req;
	
	public CookieUtils(HttpServletRequest req) {
		super();
		this.req = req;
		cookieMap = new LinkedHashMap<>();
		Cookie[] cookies = req.getCookies();
		for(Cookie tmp : cookies) {
			cookieMap.put(tmp.getName(), tmp);
		}
	}
	
	/**
	 * 쿠키 검색
	 * @param name : 검색할 쿠키명 
	 * @return 존재하지 않는 경우, null 반환.
	 */
	public Cookie getCookie(String name) {
		return cookieMap.get(name);
	}
	
	/**
	 * 쿠키값 조회
	 * @param name
	 * @return 존재하지 않으면, null 반환
	 * @throws IOException
	 */
	public String getCookieValue(String name) throws IOException{
		Cookie cookie = getCookie(name);
		String value = null;
		if(cookie != null)
			value = URLDecoder.decode(cookie.getValue(), "UTF-8");
		return value;
	}
	
	public boolean exists(String name) {
		return cookieMap.containsKey(name);
	}
	
}
