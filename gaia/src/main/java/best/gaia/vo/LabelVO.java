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
public class LabelVO {
	
	public LabelVO(Integer proj_no, String label_nm, String label_icon, String label_color ){
		this.proj_no = proj_no;
		this.label_nm = label_nm;
		this.label_icon = label_icon;
		this.label_color = label_color;
	}
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotNull @Min(0) private Integer label_no;
	@NotNull @Min(0) private Integer proj_no;
	@NotBlank@Size(max=200) private String label_nm;
	@NotBlank@Size(max=200) private String label_icon;
	@NotBlank@Size(max=20) private String label_color;
	
}
