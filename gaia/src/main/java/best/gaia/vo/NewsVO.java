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
public class NewsVO {
	@NotNull @Min(0) private Integer news_sid;
	@NotNull @Min(0) private Integer proj_no;
	@NotNull @Min(0) private Integer writerMemno;
	private String writerNickname;
	private String writerPicture;
	@NotNull @Min(0) private Integer news_no;
	@NotBlank@Size(max=200) private String news_title;
	@NotBlank@Size(max=4000) private String news_cont;
	@Size(max=7) private String news_write_date;
	 private Integer atch_file_sid;
	 private List<NewsCommentVO> commentList;
}
