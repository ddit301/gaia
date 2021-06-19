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
public class MenuVO {
	@NotNull @Min(0) private Integer menu_no;
	@NotBlank@Size(max=200) private String menu_icon;
	@Size(max=200) private String menu_data;
	@Size(max=200) private String menu_code;
	 private Integer menu_set_index;
	@NotBlank@Size(max=200) private String menu_nm_eng;
	@NotBlank@Size(max=200) private String menu_nm_kor;
	 private Integer menu_parent;

}
