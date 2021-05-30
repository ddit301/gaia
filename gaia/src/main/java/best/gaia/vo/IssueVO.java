package best.gaia.vo;

import java.util.List;
import java.util.Map;
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
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotNull @Min(0) private Integer issue_sid;
	@NotNull @Min(0) private Integer issue_no;
	@NotNull @Min(0) private Integer mem_no;
	 private Integer label_no;
	 private Integer milest_sid;
	@NotNull @Min(0) private Integer proj_no;
	@NotBlank@Size(max=200) private String issue_title;
	@Size(max=7) private String issue_create_date;
	@Size(max=7) private String issue_start_date;
	@Size(max=7) private String issue_end_date;
	@NotBlank@Size(max=1) private String issue_status;
	@NotNull @Min(0) private Integer issue_priority;
	 private Integer progress;
	
	/**
	 * 위 COLUMN 중 FK 에 해당하는 값들의 관계를 위한 객체 입니다.
	 */
	 private MemberVO writer;
	 private MilestoneVO milestone;
	 private Set<MemberVO> assigneeList;
	 private List<IssueHistoryVO> historyList;
	 private Map<String, Object> label;
	 
	/**
	 * 필요에 따라 추가된 프로퍼티 입니다.
	 */
	 
	 private int replyCount;
	 private String url;
}
