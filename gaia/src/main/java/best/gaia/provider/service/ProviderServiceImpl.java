package best.gaia.provider.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import best.gaia.provider.dao.ProviderDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.InquiryCommentVO;
import best.gaia.vo.InquiryVO;
import best.gaia.vo.MemberVO;
import best.gaia.vo.PagingVO;

@Service
public class ProviderServiceImpl implements ProviderService {

	@Inject
	private ProviderDao dao;
	private static final Logger logger = LoggerFactory.getLogger(ProviderServiceImpl.class);

	@Override
	public List<MemberVO> retrieveAllMember() {
		return dao.selectAllMemberList();
	}
	@Override
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO) {
		return dao.selectMemberCount(pagingVO);
	}

	@Override
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO) {
		return dao.selectMemberList(pagingVO);
	}
	@Override
	public List<InquiryVO> retrieveAllInquiryQuestion() {
		return dao.selectInquiryQuestionList();
	}
	@Override
	public InquiryCommentVO retrieveInquiryAnswer(int inq_no) {
		return dao.selectInquiryAnswer(inq_no);
	}
	@Override
	public ServiceResult enrollInquiryAnswer(InquiryCommentVO inquiryComment) {
		ServiceResult result = ServiceResult.FAIL;
		if(dao.insertInquiryAnswer(inquiryComment)==1) 
			result = ServiceResult.OK;
		return result;
	}

}
