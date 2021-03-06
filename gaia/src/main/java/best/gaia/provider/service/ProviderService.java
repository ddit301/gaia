package best.gaia.provider.service;

import java.util.List;

import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.InquiryCommentVO;
import best.gaia.vo.InquiryVO;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

public interface ProviderService {
	
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);
	public List<MemberVO> retrieveAllMember();

	public List<InquiryVO> retrieveAllInquiryQuestion();
	public InquiryCommentVO retrieveInquiryAnswer(int inq_no);
	public int enrollInquiryAnswer(InquiryCommentVO inquiryComment);
	
}
