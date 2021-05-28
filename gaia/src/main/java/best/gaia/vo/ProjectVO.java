package best.gaia.vo;

import java.util.List;

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
public class ProjectVO {
	@NotNull @Min(0) private Integer proj_no;
	 private Integer mem_no;
	@NotBlank@Size(max=200) private String proj_title;
	@NotBlank@Size(max=3000) private String proj_cont;
	@Size(max=7) private String proj_start_date;
	@Size(max=7) private String proj_est_end_date;
	@NotNull @Min(0) private Integer issue_priority_set;
	@NotNull @Min(0) private Integer proj_module_set;
	private List<IssueVO> issueList;
}
