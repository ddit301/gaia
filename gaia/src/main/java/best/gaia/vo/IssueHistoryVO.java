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
public class IssueHistoryVO {
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	 @NotNull @Min(0) private Integer issue_his_no;
	 @NotNull @Min(0) private Integer issue_sid;
	 @NotNull @Min(0) private Integer mem_no;
	 @NotBlank@Size(max=4000) private String issue_his_cont;
	 @Size(max=7) private String issue_his_date;
	 @NotBlank@Size(max=50) private String issue_his_type;
	  private Integer atch_file_sid;
	  
	/**
	 * Association 관계의 객체 입니다.
	 */	  
	  private MemberVO historyWriter;
}
