package best.gaia.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {
	public static void addCookie(String name, String value, HttpServletResponse resp) {
		try {
			value = URLEncoder.encode(value, "utf-8").replaceAll("\\+", "%20");
		} catch (UnsupportedEncodingException e) {}
		Cookie cookie = new Cookie(name,value);
		cookie.setPath("/");
		resp.addCookie(cookie);
	}
	
	public static String getCookie(String name, HttpServletRequest req) {
		Cookie[] cookies = req.getCookies();
		if(cookies!=null) {
			for(Cookie tmp : cookies) {
				if(name.equals(tmp.getName())) {
					try {
						return URLDecoder.decode(tmp.getValue(), "utf-8");
					} catch (UnsupportedEncodingException e) {}
				}
			}
		}
		return null;
		
	}
	
}
