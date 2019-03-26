package com.saisiot.profile.dao;

import com.saisiot.profile.dto.ProfileDto;

public interface ProfileDao {
	
	String NAMESPACE="profile.";
	
	public int insert_P(String email);
	public int update_p(ProfileDto Pdto);

}
