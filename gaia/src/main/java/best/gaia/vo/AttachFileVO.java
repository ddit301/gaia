package best.gaia.vo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
/**
 * 
 * @author Eisen
 * @since Jun 2, 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * Jun 2, 2021  Eisen    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 */

@Data
@EqualsAndHashCode(of="atch_file_sid")
@NoArgsConstructor
@AllArgsConstructor
public class AttachFileVO {
   private transient MultipartFile file;
   
   public AttachFileVO(MultipartFile file) {
      super();
      this.file = file;
      this.file_nm = file.getOriginalFilename();
      this.save_file_nm = UUID.randomUUID().toString();
      this.file_cont_type = file.getContentType();
      this.file_size = file.getSize();
   }
   
   private Integer atch_file_sid;
   private Integer atch_file_no;
   private String biz_type;
   private Integer mem_no;
   private String file_nm;
   private Integer file_down_cnt;
   private long file_size;
   private String file_path;
   private String reg_date;
   private String save_file_nm;
   private String upd_date;
   private String upd_mem_no;
   private String file_cont_type;
   
   private String file_img;
   
//   public void saveTo(File saveFolder) throws IOException {
//      file.transferTo(new File(saveFolder.getAbsolutePath(), save_filenm));
//   }
   public void saveTo(File saveFolder) throws IOException {
      file.transferTo(new File(saveFolder, save_file_nm));
   }
   public void saveTo(File saveFolder, String saveFileName) throws IOException {
	   file.transferTo(new File(saveFolder, saveFileName));
   }
   public void saveTo(String saveFolder, String saveFileName) throws IOException {
	   file.transferTo(new File(saveFolder, saveFileName));
   }
}