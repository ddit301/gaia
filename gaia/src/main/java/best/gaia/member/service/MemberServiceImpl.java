package best.gaia.member.service;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Service;

import best.gaia.member.dao.MemberDao;
import best.gaia.utils.enumpkg.ServiceResult;
import best.gaia.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberDao dao;

	@Override
	public ServiceResult authenticate(MemberVO user) {
		MemberVO savedUser = dao.selectUser(user.getMEM_EMAIL());
		ServiceResult result = null;
		if(savedUser != null) {
			String inputPass = user.getMEM_PASS();
			try {
				String encodedPass = inputPass; // do not encrypt as column size is too small
				String savedPass = savedUser.getMEM_PASS();
				if(savedPass.equals(encodedPass)) {
					try {
						BeanUtils.copyProperties(user, savedUser);
					} catch (IllegalAccessException | InvocationTargetException e) {
						e.printStackTrace();
					}
					result = ServiceResult.OK;
				}else {
					result = ServiceResult.INVALIDPASSWORD;
				}
			}catch (Exception e) {
				result = ServiceResult.FAIL;
			}
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	@Override
	public List<MemberVO> selectUserList() {
		return dao.selectUserList();
	}

	@Override
	public MemberVO selectUser(String user_id) {
		return dao.selectUser(user_id);
	}


}