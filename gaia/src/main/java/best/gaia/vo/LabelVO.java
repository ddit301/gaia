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
	
	public LabelVO(String label_nm){
		this.label_nm = label_nm;
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
