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
public class InquiryCommentVO {
	@NotNull
	@Min(0)
	private Integer inq_com_no;
	@NotNull
	@Min(0)
	private Integer inq_no;
	@Size(max = 200)
	private String prov_id;
	@NotBlank
	@Size(max = 4000)
	private String inq_com_cont;
	@Size(max = 7)
	private String inq_com_date;
	private Integer atch_file_sid;
}
