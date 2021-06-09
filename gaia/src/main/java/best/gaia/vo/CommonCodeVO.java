package best.gaia.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommonCodeVO {
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotBlank @Size(max=50) private String com_code_grp;
	@NotBlank @Size(max=50) private String com_code;
	@NotBlank @Size(max=200) private String com_code_nm;
	@NotBlank @Size(max=400) private String com_code_desc;
	@NotBlank @Size(max=1) private String use_yn;
}
