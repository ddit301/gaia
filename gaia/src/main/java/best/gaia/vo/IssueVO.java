package best.gaia.vo;

import java.util.List;
import java.util.Set;

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
	@NotNull @Min(0) private Integer issue_no;
	@NotNull @Min(0) private Integer writer_no;
	private String writer_nick;
	private String writer_pic;
	 private Integer label_no;
	 private String label_nm;
	 private Integer milest_sid;
	 private String milest_title;
	 private String url;
	@NotNull @Min(0) private Integer proj_no;
	@NotBlank@Size(max=200) private String issue_title;
	@Size(max=7) private String issue_create_date;
	@Size(max=7) private String issue_start_date;
	@Size(max=7) private String issue_end_date;
	@NotBlank@Size(max=1) private String issue_status;
	@NotNull @Min(0) private Integer issue_priority;
	 private Integer progress; 
	 private Set<MemberVO> assigneeList;
	 private List<IssueHistoryVO> historyList;
}
