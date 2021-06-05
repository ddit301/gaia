package best.gaia.vo;

import java.util.List;
import java.util.Map;

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
public class WikiVO {
	
	/**
	 *  wiki table 에 존재하는column.
	 */
	
	@NotNull @Min(0) private Integer wiki_sid;
	 private Integer parent_wiki;
	@NotNull @Min(0) private Integer mem_no;
	@NotNull @Min(0) private Integer proj_no;
	@NotNull @Min(0) private Integer wiki_no;
	@NotBlank@Size(max=4000) private String wiki_cont;
	@Size(max=7) private String wiki_write_date;
	
}
