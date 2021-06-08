
package best.gaia.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "mem_pass")
@EqualsAndHashCode(of= {"mem_no", "mem_id"})
public class MemberVO implements UserDetails, Serializable {

	private static final long serialVersionUID = 1L;
	@NotNull
	@Min(0)
	private Integer mem_no; // 회원 번호
	@NotBlank
	@Size(max = 200)
	private String mem_id; // 회원 아이디
	@NotBlank
	@Size(max = 1000)
	private transient String mem_pass; // 회원 비밀번호
	@NotBlank
	@Size(max = 200)
	private String mem_nick; // 회원 닉네임
	@Size(max = 100)
	private String mem_tel; // 회원 전화번호
	@Size(max = 200)
	private String mem_pic_file_name; // 회원 프로필 파일 이름
	@Size(max = 7)
	private String mem_sign_date; // 회원 가입 일자
	@Size(max = 7)
	private String mem_quit_date; // 회원 탈퇴 일자
	@Size(max = 200)
	private String mem_nm; // 회원 이름
	@Size(max = 4000)
	private String mem_bio; // 회원 자기소개 내용
	@Size(max = 200)
	private String mem_working_city; // 회원 근무 도시
	@Size(max = 50)
	private String mem_status; // 회원 상태
	
	private boolean enabled = StringUtils.isBlank(mem_quit_date) ? true : false;

	public MemberVO(String mem_id, String mem_pass) {
		super();
		this.mem_id = mem_id;
		this.mem_pass = mem_pass;
	}

	/**
	 * Collnection 관계의 객체입니다.
	 */
	private List<AttachFileVO> attachFileList;
	private List<ProjectVO> projectList;
	/**
	 * 필요에 따라 추가된 프로퍼티 입니다.
	 */
	private transient MultipartFile[] files; // 회원 프로필 파일 얻기 위한 multipart
	
	// profile을 위한 메서드 file
	// multipart와 attatchList와 연동시킬 값들을 구해주는 메서드 
	public void setFiles(MultipartFile[] files) {  
		this.files = files;
		if(files!=null) {
			List<AttachFileVO> attatchList = new ArrayList<>();
			for(MultipartFile file : files) {
				if(file.isEmpty()) continue;
				attatchList.add(new AttachFileVO(file));
			}
			if(attatchList.size()>0)
				this.attachFileList = attatchList;
		}
	}
	
	/**
	 * UserDetails 객체에서 상속된 메서드 입니다.
	 */	 
	
	@Override
	public String getPassword() {
		return mem_pass;
	}

	@Override
	public String getUsername() {
		return mem_id;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return enabled;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}


}
