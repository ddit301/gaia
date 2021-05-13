package best.gaia.utils;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CryptoUtil {
	/**
	 * 문자열을 MD5 방식으로 암호화(해시) 한다.
	 * @param str 암호화 할 문자열
	 * @return 암호화 된 문자열
	 * @throws NoSuchAlgorithmException 
	 */
	public static String md5(String str) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(str.getBytes());
		return Base64.getEncoder().encodeToString(md.digest());
	}

	public static String sha256(String str) throws NoSuchAlgorithmException{
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(str.getBytes());
		return Base64.getEncoder().encodeToString(md.digest());
	}
	
	public static String sha512(String str) throws NoSuchAlgorithmException{
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		md.update(str.getBytes());
		return Base64.getEncoder().encodeToString(md.digest());
	}
	
	/**
	 * AES 256 방식으로 암호화 하는 메서드
	 * @param str 암호화 할 문자열
	 * @param key 암호키 값 문자열 (16자 이상)
	 * @return 암호화 된 문자열
	 * @throws UnsupportedEncodingException 
	 * @throws NoSuchPaddingException 
	 * @throws NoSuchAlgorithmException 
	 * @throws InvalidAlgorithmParameterException 
	 * @throws InvalidKeyException 
	 * @throws BadPaddingException 
	 * @throws IllegalBlockSizeException 
	 */
	public static String encryptAES256(String str, String key) throws UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		String iv = key.substring(0,16);
		byte[] keyBytes = new byte[16];
		byte[] b = key.getBytes("UTF-8");
		int len = keyBytes.length;
		System.arraycopy(b, 0, keyBytes, 0, len);
		
		// 비밀 키 생성
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		
		// Cipher 객체 생성 및 초기화
		// 알고리즘 / 모드/ 패딩
		// CBC => Cipher Block Chaining Mode
		//	동일한 평문 블록과 암호문의 블록의 쌍이 발생하지 않도록
		//	이전 단계의 암복호화한 결과가 현 단계에 영향을 주는 운영모드
		
		// Padding ==> 마지막 블록이 블록의 길이와 항상 딱 맞아 떨어지지
		//	않기 때문에 부족한 만큼을 '0' 으로 채우거나 임의의
		// 비트로 채워 넣는 것을 말한다.
		//
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		
		byte[] ivBytes = new byte[16];
		System.arraycopy(iv.getBytes(), 0, ivBytes, 0, ivBytes.length);
		
		// 옵션 종류에 맞게 초기화한다.
		c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(ivBytes));
		
		// 암호문 생성
		byte[] encryped = c.doFinal(str.getBytes("UTF-8"));
		
		String enStr = Base64.getEncoder().encodeToString(encryped);
		
		return enStr;
		
	}
	
	/**
	 * encryptAES256() 메서드로 암호화 한 내용을 복호화하는 메서드
	 * @param str 복호화 할 문자
	 * @param key 암호 키 문자
	 * @return 복호화 된 문자열(원래의 문자열)
	 * @throws NoSuchPaddingException 
	 * @throws NoSuchAlgorithmException 
	 * @throws UnsupportedEncodingException 
	 * @throws InvalidAlgorithmParameterException 
	 * @throws InvalidKeyException 
	 * @throws BadPaddingException 
	 * @throws IllegalBlockSizeException 
	 */
	public static String decryptAES256(String str, String key) throws NoSuchAlgorithmException, NoSuchPaddingException, UnsupportedEncodingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		String iv = key.substring(0,16);
		byte[] keyBytes = new byte[16];
		byte[] b = key.getBytes("UTF-8");
		int len = keyBytes.length;
		System.arraycopy(b, 0, keyBytes, 0, len);
		
		// 비밀 키 생성
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		
		// Cipher 객체 생성 및 초기화
		// 알고리즘 / 모드/ 패딩
		// CBC => Cipher Block Chaining Mode
		//	동일한 평문 블록과 암호문의 블록의 쌍이 발생하지 않도록
		//	이전 단계의 암복호화한 결과가 현 단계에 영향을 주는 운영모드
		
		// Padding ==> 마지막 블록이 블록의 길이와 항상 딱 맞아 떨어지지
		//	않기 때문에 부족한 만큼을 '0' 으로 채우거나 임의의
		// 비트로 채워 넣는 것을 말한다.
		//
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		
		byte[] ivBytes = new byte[16];
		System.arraycopy(iv.getBytes(), 0, ivBytes, 0, ivBytes.length);
		
		// 옵션 종류에 맞게 초기화한다.
		c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(ivBytes));
		
		// 복호화 할 문자열을 decoding 해서 암호화 된 byte 배열을 구한다.
		byte[] byteStr = Base64.getDecoder().decode(str);
		
		// 복호화 된 데이터를 문자열로 반환한다.
		return new String(c.doFinal(byteStr), "UTF-8");
	}
	
	

}
