package best.gaia.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexUtils {
	
	public static String filteringTokens(String origin, String replace, String...tokens) {
//		"말미잘", "해삼", "멍게"
//		"말미잘|해삼|멍게"
		String regex = String.format("(%s)", String.join("|", tokens) );
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(origin);
		StringBuffer result = new StringBuffer();
		
		while(matcher.find()) {
			matcher.appendReplacement(result, replace);
		}
		matcher.appendTail(result);
		return result.toString();
	}
	
	public static String filteringTokens(String origin, char maskingCh, String...tokens) {
//		"말미잘", "해삼", "멍게"
//		"말미잘|해삼|멍게"
		String regex = String.format("(%s)", String.join("|", tokens) );
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(origin);
		StringBuffer result = new StringBuffer();
		
		while(matcher.find()) {
			String replace = matcher.group(1).replaceAll(".", new Character(maskingCh).toString());
			matcher.appendReplacement(result, replace);
		}
		matcher.appendTail(result);
		return result.toString();
	}
	
}
