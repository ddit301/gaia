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
public class NewsCommentVO {
	@NotNull @Min(0) private Integer news_com_no;
	@NotNull @Min(0) private Integer commenterMemno;
	private String commenterNickname;
	private String commenterPicture;
	@NotBlank@Size(max=4000) private String news_com_cont;
	@Size(max=7) private String news_com_date;
}
