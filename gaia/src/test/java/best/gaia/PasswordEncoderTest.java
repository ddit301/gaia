package best.gaia;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@TestWebAppConfiguration
public class PasswordEncoderTest {

	@Inject
	PasswordEncoder encoder;
	
	@Test
	public void test() {
		String plain = "java";
	    String encoded = encoder.encode(plain);
	    System.out.println(encoded);
	}

}


