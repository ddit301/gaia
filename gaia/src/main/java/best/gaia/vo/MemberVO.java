package best.gaia.vo;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO implements UserDetails, Serializable {

	@NotNull @Min(0) private Integer mem_no;            // 회원 번호
	@NotBlank@Size(max=200) private String mem_id;      // 회원 아이디(이메일)
	@NotBlank@Size(max=1000) private String mem_pass;   // 회원 비밀번호
	@NotBlank@Size(max=200) private String mem_nick;    // 회원 닉네임
	@Size(max=100) private String mem_tel;              // 회원 전화번호
	@Size(max=200) private String mem_pic_file_name;    // 회원 프로필 파일 이름
	@Size(max=7) private String mem_sign_date;          // 회원 가입 일자
	@Size(max=7) private String mem_quit_date;          // 회원 탈퇴 일자
	@Size(max=200) private String mem_nm;               // 회원 이름
	@Size(max=4000) private String mem_bio;             // 회원 자기소개 내용
	@Size(max=200) private String mem_working_city;     // 회원 근무 도시
	@Size(max=50) private String mem_status;          // 회원 상태
	private List<GrantedAuthority> authorities;
	private boolean enabled = mem_status.equals("ACTIVE") ? true : false;

	public MemberVO(String mem_id, String mem_pass) {
		super();
		this.mem_id = mem_id;
		this.mem_pass = mem_pass;
	}

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
		MemberVO other = (MemberVO) obj;
		if (mem_no != other.mem_no)
			return false;
		if (mem_id == null) {
			if (other.mem_id != null)
				return false;
		} else if (!mem_id.equals(other.mem_id))
			return false;
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + mem_no;
		result = prime * result + ((mem_id == null) ? 0 : mem_id.hashCode());
		return result;
	}

}
