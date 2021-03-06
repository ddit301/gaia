package best.gaia.vo;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode(of= {"chatroom_no"})
public class ChatRoomVO {
	private Integer chatroom_no;
	private String chatroom_alarm;
	private String chatroom_title;
	private String chatroom_create_date;
	/**
	 * Collnection 관계의 객체입니다.
	 */
	private List<MemberVO> memberList;
	/**
	 * 필요에 따라 추가된 프로퍼티 입니다.
	 */
	private List<Map<String, Object>> chatList;
}
