package best.gaia.vo;

import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NewsVO {
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */	
	@NotNull @Min(0) private Integer news_sid;
	@NotNull @Min(0) private Integer proj_no;
	@NotNull @Min(0) private Integer mem_no;
	@NotNull @Min(0) private Integer news_no;
	@NotBlank@Size(max=200) private String news_title;
	@NotBlank@Size(max=4000) private String news_cont;
	@Size(max=7) private String news_write_date;
	 private String atch_file_sid;
	 
	/**
	 * Association 관계의 객체 입니다.
	 */	  
	 private MemberVO writer;
	 
	/**
	 * Collnection 관계의 객체입니다.
	 */
	 private List<NewsCommentVO> commentList;
}
