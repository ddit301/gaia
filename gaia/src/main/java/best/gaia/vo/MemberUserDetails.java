package best.gaia.vo;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class MemberUserDetails extends User{
	
	private MemberVO adaptee;

 	public MemberUserDetails(MemberVO adaptee) {
 		super(adaptee.getMem_id(), adaptee.getMem_pass(), AuthorityUtils.createAuthorityList(adaptee.getMem_role()));
 		this.adaptee = adaptee;
 	}
}
