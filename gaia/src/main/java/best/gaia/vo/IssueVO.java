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
public class IssueVO {
	@NotNull @Min(0) private Integer issue_sid;
	 private Integer parent_issue;
	 private Integer label_no;
	 private Integer milest_sid;
	@NotNull @Min(0) private Integer proj_mem_no;
	@NotBlank@Size(max=200) private String issue_title;
	@Size(max=7) private String issue_create_date;
	@Size(max=7) private String issue_start_date;
	@Size(max=7) private String issue_end_date;
	@NotBlank@Size(max=1) private String issue_status;
	@NotNull @Min(0) private Integer priority;
	 private Integer progress;
	@NotNull @Min(0) private Integer issue_no;
}
