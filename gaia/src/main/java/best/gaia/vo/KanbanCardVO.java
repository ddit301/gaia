package best.gaia.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class KanbanCardVO {
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotNull @Min(0) private Integer kb_card_no;
	 private Integer kb_card_priv_no;
	 private Integer mem_no;
	 private Integer kb_col_no;
	 private Integer issue_sid;
	@Size(max=4000) private String kb_card_cont;
	@Size(max=7) private String kb_card_write_date;
	
	/**
	 * Association 관계의 객체 입니다.
	 */	  	
	private MemberVO writer;
	private IssueVO issue;
	
	/**
	 * 필요에 따라 추가된 프로퍼티 입니다.
	 */
	private Integer kb_card_next_no;
	
}
