package best.gaia.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProjMemVO {
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotNull @Min(0) private Integer mem_no;
	@NotNull @Min(0) private Integer proj_no;
	@NotNull @Min(0) private Integer mem_role_no;
	@Size(max=7) private String proj_join_date;
	@Size(max=7) private String proj_drop_date;
	@Size(max=200) private String proj_user_nick;
	
	/**
	 * Association 관계의 객체 입니다.
	 */	  
	 private MemberVO member;
	 
	 /**
	  * 필요에 의해 추가된 property 입니다.
	  */	  
	 private String mem_role_nm;
	
}
