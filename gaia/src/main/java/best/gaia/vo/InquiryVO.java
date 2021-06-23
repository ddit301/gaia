package best.gaia.vo;

import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class InquiryVO {
	@NotNull
	@Min(0)
	private Integer inq_no;
	@NotNull
	@Min(0)
	private Integer mem_no;
	@NotBlank
	@Size(max = 4000)
	private String inq_cont;
	@Size(max = 7)
	private String inq_date;
	@Size(max = 1)
	private String inq_status_yn;
	@JsonIgnore
	private List<AttachFileVO> attachFileList;
	@JsonIgnore
	private transient MultipartFile[] files; 
}
