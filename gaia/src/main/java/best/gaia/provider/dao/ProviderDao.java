package best.gaia.provider.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.InquiryCommentVO;
import best.gaia.vo.InquiryVO;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;


@Repository
public interface ProviderDao {
	
	public int selectMemberCount(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> selectMemberList(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> selectAllMemberList();

	public List<InquiryVO> selectInquiryQuestionList();
	public InquiryCommentVO selectInquiryAnswer(int inq_no);
	public int insertInquiryAnswer(InquiryCommentVO inquiryComment);
	
}
