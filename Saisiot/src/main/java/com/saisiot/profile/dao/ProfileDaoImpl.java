package com.saisiot.profile.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saisiot.profile.dto.ProfileDto;

@Repository
public class ProfileDaoImpl implements ProfileDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ProfileDaoImpl() {
		System.out.println("dao객체 생성");
	}
	
	@Override
	public int insert_P(String email) {
		int res = 0;
		if(sqlSession==null) {
			System.out.println("null break");
			return 0;
		}
		res = sqlSession.insert(NAMESPACE + "insert_p", email);
		
		return res;
	}

	@Override
	public int update_p(ProfileDto Pdto) {
		int res = 0;
		
		return res;
	}

	
}
