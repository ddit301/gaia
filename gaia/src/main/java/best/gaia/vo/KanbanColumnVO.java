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
public class KanbanColumnVO {	
	
	public KanbanColumnVO(String kb_col_nm) {
		this.kb_col_nm = kb_col_nm;
	}
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotNull @Min(0) private Integer kb_col_no;
	 private Integer kb_col_priv_no;
	@NotNull @Min(0) private Integer proj_no;
	@NotBlank@Size(max=500) private String kb_col_nm;
	
	/**
	 * Collnection 관계의 객체입니다.
	 */
	private List<KanbanCardVO> cardList;
	
}
