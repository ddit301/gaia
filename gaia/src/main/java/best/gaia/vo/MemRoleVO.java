package best.gaia.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemRoleVO {
	
	public MemRoleVO(Integer proj_no,String mem_role_nm,Integer authority){
		this.proj_no = proj_no;
		this.mem_role_nm = mem_role_nm;
		this.authority = authority;
	}
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotNull @Min(0) private Integer mem_role_no;
	@NotNull @Min(0) private Integer proj_no;
	@NotBlank@Size(max=200) private String mem_role_nm;
	 private Integer authority;
	
}
