package com.saisiot.profile.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.saisiot.profile.dao.ProfileDao;
import com.saisiot.profile.dao.ProfileDaoImpl;
import com.saisiot.profile.dto.ProfileDto;

@Service
public class ProfileBizImpl implements ProfileBiz{
	
	@Autowired
	private ProfileDao dao;
	
	@Override
	public int insert_P(String email) {
		
		dao = new ProfileDaoImpl();
		
		if(dao == null) {
			System.out.println("널이다!");
		}else {
			System.out.println(">>>>>>>>>>>"+dao.insert_P(email));
		}
		
		return dao.insert_P(email);
	}

	@Override
	public int update_p(ProfileDto Pdto) {
		
		return dao.update_p(Pdto);
	}

}
