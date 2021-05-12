package best.gaia.lunch.service;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Service;

import best.gaia.enumpkg.ServiceResult;
import best.gaia.lunch.dao.LunchDao;
import best.gaia.vo.MemberVO;

@Service
public class LunchServiceImpl implements LunchService{
	
	@Inject
	private LunchDao dao;

	@Override
	public ServiceResult authenticate(MemberVO user) {
		MemberVO savedUser = dao.selectUser(user.getMember_id());
		ServiceResult result = null;
		if(savedUser != null) {
			String inputPass = user.getMember_pass();
			try {
				String encodedPass = inputPass; // do not encrypt as column size is too small
				String savedPass = savedUser.getMember_pass();
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
