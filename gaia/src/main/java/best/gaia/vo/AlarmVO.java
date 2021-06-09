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
public class AlarmVO {
	
	/**
	 * TABLE에 존재하는 COLUMN들 입니다.
	 */
	@NotNull @Min(0) private Integer alarm_no;
	@NotNull @Min(0) private Integer mem_no;
	@NotBlank@Size(max=4000) private String alarm_cont;
	@Size(max=7) private String alarm_create_date;
	@Size(max=7) private String alarm_chk_date;
	@NotBlank@Size(max=50) private String alarm_type;
	
	// 필요에 의해 만든 프로퍼티들 입니다.
	String url;
	
}
