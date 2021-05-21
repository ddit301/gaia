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
public class MilestoneVO {
	@NotNull @Min(0) private Integer milest_sid;
	@NotNull @Min(0) private Integer proj_mem_no;
	@NotBlank@Size(max=200) private String milest_title;
	@NotBlank@Size(max=3000) private String milest_cont;
	@Size(max=7) private String milest_date;
	@Size(max=7) private String milest_start_date;
	@Size(max=7) private String milest_end_date;
	@NotNull @Min(0) private Integer milest_no;
	private Integer milest_percent;
}
