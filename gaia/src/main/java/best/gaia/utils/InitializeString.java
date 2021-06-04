package best.gaia.utils;

public class InitializeString {
	public static String initializer(String name) {
		String result= "";
		char p = ' ';
		for(char tmp : name.toCharArray()) {
			if(p==' ' || Character.isUpperCase(tmp)) {
			result+=tmp;
			}
				p=tmp;
			if(result.length()>=3) break;
		}
		return result.toUpperCase();
	}

}
