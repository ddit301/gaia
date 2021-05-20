package best.gaia.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	private int mem_no;             //회원 번호
	private String mem_id;          //회원 아이디(이메일)
	private String mem_pass;        //회원 비밀번호
	private String mem_nick;        //회원 닉네임
	private String mem_tel;         //회원 전화번호
	private String mem_pic_name;    //회원 프로필 사진 이름
	private String mem_sign_date;   //회원 가입 일자
	private String mem_secsn_date;  //회원 탈퇴 일자
	private String mem_name;        //회원 이름
	private String mem_bio;         //회원 자기소개 내용
	private String mem_working_city;//회원 근무 도시
	private String mem_status;      //회원 상태
}
