package best.gaia.domain;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@ToString
public class User implements UserDetails, Serializable{


	private static final long serialVersionUID = 5444433816838838290L;
	
	@Id @GeneratedValue
	private int mem_no;             //회원 번호
	private String mem_id;          //회원 아이디(이메일)
	private String mem_pass;        //회원 비밀번호
	private String mem_nick;        //회원 닉네임
	private String mem_tel;         //회원 전화번호
	private String mem_pic_name;    //회원 프로필 사진 이름
	private String mem_sign_date;   //회원 가입 일자
	private String mem_secsn_date;  //회원 탈퇴 일자
	private String mem_name;        //회원 이름
	private String mem_bio;         //회원 자기소개 내용
	private String mem_working_city;//회원 근무 도시
	private String mem_status;      //회원 상태
	private List<GrantedAuthority> authorities;
	private boolean enabled = mem_status.equals("ACTIVE")? true: false;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return mem_pass;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return mem_id;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return enabled;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return enabled;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return enabled;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return enabled;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (mem_no != other.mem_no)
			return false;
		if (mem_pass == null) {
			if (other.mem_pass != null)
				return false;
		} else if (!mem_pass.equals(other.mem_pass))
			return false;
		return true;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + mem_no;
		result = prime * result + ((mem_pass == null) ? 0 : mem_pass.hashCode());
		return result;
	}
	
}