package best.gaia.vo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * 
 * @author Robin
 * @since 2021. 5. 20
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 2021. 5. 20  Robin    Initial Commit
 * Copyright (c) 2021 by team SEED All right reserved
 * </pre>
 */

@Service
public class KakaoService {

//	get access_Token by authorize_code 
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=a31ddbbfbc730c92670b6e2f2ead67b5");
			sb.append("&redirect_uri=http://localhost/oauth");
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			// standard response code
			int responseCode = conn.getResponseCode();
			
//			-101	해당 앱에 카카오계정 연결이 완료되지 않은 사용자가 호출한 경우
//			해결 방법: 카카오계정 연결 후 재시도	400
//			-201	사용자 정보 요청 API나 사용자 정보 저장 API 호출 시 앱에 추가하지 않은 사용자 프로퍼티 키 값을 불러오거나 저장하려고 한 경우
//			해결 방법: [내 애플리케이션] > [제품 설정] > [카카오 로그인] > [사용자 프로퍼티]에서 설정한 사용자 프로퍼티 키와 요청 파라미터가 일치하도록 설정
//			400
//			-401	유효하지 않은 앱키나 액세스 토큰으로 요청한 경우, 등록된 앱 정보와 호출된 앱 정보가 불일치 하는 경우
//			해결 방법: 앱키 확인 또는 토큰 갱신, 개발자 사이트에 등록된 앱정보 확인	401
//			-402	해당 API에서 접근하는 리소스에 대해 사용자의 동의를 받지 않은 경우
//			해결 방법: 응답바디의 required_scopes을 확인하여 사용자에게 해당 동의항목을 추가 동의 받도록 요청	403
//			-406	14세 미만 미허용 설정이 되어 있는 앱으로 14세 미만 사용자가 API 호출한 경우	401
//			
//			if(responseCode>=400) {
//				 throw new RuntimeException("Wrong");
//			}

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			//response message
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}

			// JsonObject constructed
			JsonElement element = JsonParser.parseString(result).getAsJsonObject();
			
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return access_Token;
	}
	
	
	public HashMap<String, Object> getUserInfo(String access_Token) {

		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			
			// standard response code
			int responseCode = conn.getResponseCode();
			
//			-101	해당 앱에 카카오계정 연결이 완료되지 않은 사용자가 호출한 경우
//			해결 방법: 카카오계정 연결 후 재시도	400
//			-201	사용자 정보 요청 API나 사용자 정보 저장 API 호출 시 앱에 추가하지 않은 사용자 프로퍼티 키 값을 불러오거나 저장하려고 한 경우
//			해결 방법: [내 애플리케이션] > [제품 설정] > [카카오 로그인] > [사용자 프로퍼티]에서 설정한 사용자 프로퍼티 키와 요청 파라미터가 일치하도록 설정
//			400
//			-401	유효하지 않은 앱키나 액세스 토큰으로 요청한 경우, 등록된 앱 정보와 호출된 앱 정보가 불일치 하는 경우
//			해결 방법: 앱키 확인 또는 토큰 갱신, 개발자 사이트에 등록된 앱정보 확인	401
//			-402	해당 API에서 접근하는 리소스에 대해 사용자의 동의를 받지 않은 경우
//			해결 방법: 응답바디의 required_scopes을 확인하여 사용자에게 해당 동의항목을 추가 동의 받도록 요청	403
//			-406	14세 미만 미허용 설정이 되어 있는 앱으로 14세 미만 사용자가 API 호출한 경우	401
//			
//			if(responseCode>=400) {
//				 throw new RuntimeException("Wrong");
//			}

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}

			JsonElement element = JsonParser.parseString(result).getAsJsonObject();

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();

			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
			userInfo.put("profile_image", profile_image);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userInfo;
	}
	
	
}