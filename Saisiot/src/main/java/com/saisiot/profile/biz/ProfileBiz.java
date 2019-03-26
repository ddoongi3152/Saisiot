package com.saisiot.profile.biz;

import com.saisiot.profile.dto.ProfileDto;

public interface ProfileBiz {
	
	public int insert_P(String email);
	public int update_p(ProfileDto Pdto);

}
