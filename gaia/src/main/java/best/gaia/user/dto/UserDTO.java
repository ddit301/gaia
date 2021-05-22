package best.gaia.user.dto;

import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
//import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
/**
 * 
 * @author Robin
 * @since 2021. 5. 22
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 2021. 5. 22  Robin    Initial Commit
 * Copyright (c) 2021 by team SEED All right reserved
 *      </pre>
 */
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
	
	@NotBlank
	private String mem_no;
	
	@JsonIgnore
	@NotBlank
	@Size(min = 4, max = 15)
	private String password;
		
	@NotBlank
	@Size(min = 6, max = 10)
	private String name;
	
	private List<GrantedAuthority> authorities;
		
	public User toEntity() {
	    return new User(mem_no, password, authorities);
	}
		
	public User toEntityWithPasswordEncode(PasswordEncoder bCryptPasswordEncoder) {
	    return new User(mem_no, bCryptPasswordEncoder.encode(password), authorities);
	}
}
