package best.gaia.vo;

import java.util.List;
import java.util.Map;

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
	/**
	 *  milestone table 에 존재하는 column. 
	 */
	
	@NotNull @Min(0) private Integer milest_sid;
	@NotNull @Min(0) private Integer mem_no;
	@NotNull @Min(0) private Integer proj_no;
	@NotNull @Min(0) private Integer milest_no;
	@NotBlank@Size(max=200) private String milest_title;
	@NotBlank@Size(max=3000) private String milest_cont;
	@Size(max=7) private String milest_date;
	@Size(max=7) private String milest_start_date;
	@Size(max=7) private String milest_end_date;
	@Size(max=1) private String milest_status;
	
	/**
	 *	Association 관계 
	 */
	
	@NotNull @Min(0) private Integer proj_mem_no;
	private MemberVO writer;
	private Map<String, Object> label;
	
	/**
	 * 	Collnection 관계 
	 */
	
	private List<IssueVO> issueList;
	
	/**
	 *	properties
	 */

	private Integer milest_percent;
	private Integer close_issue_cnt;
	private Integer open_issue_cnt;

}
