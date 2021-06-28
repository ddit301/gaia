package best.gaia.utils;
import java.io.IOException;
import java.util.HashMap;
import java.util.Properties;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;

import com.ibatis.common.resources.Resources;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Component
public class SmsUtil {
	
	private String api_key;
	private String api_secret;
	private String fromNumber;
	
	private SmsUtil() {
		Properties properties = new Properties();
		try {	// dbinfo.properties에서 문자 관련 정보 받아옵니다.
			properties.load(Resources.getResourceAsReader("best/gaia/db/dbinfo.properties"));
		} catch (IOException e) {}
		this.api_key = properties.getProperty("coolsms.api_key");
        this.api_secret = properties.getProperty("coolsms.api_secret");
        this.fromNumber = properties.getProperty("coolsms.from");
	}
	
	// 문자 메시지 보내는 메서드
	public String sendSms(String phoneNumber, String text) {
		
		String result = null;
		
		Message coolsms = new Message(api_key, api_secret);
		HashMap<String, String> params = new HashMap<String, String>();
		
		params.put("from", fromNumber);
		params.put("to", phoneNumber);
		params.put("type", "SMS");
		params.put("text", text);
		params.put("app_version", "test app 1.2"); // application name and version
		
		System.err.println(params);
		System.err.printf("%s 번호로 %s 라는 메시지를 전송합니다.",phoneNumber, text);
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			result = obj.toString();
		} catch (CoolsmsException e) {}
		
		return result;
	}
		


}