package com.saisiot.userinfo.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.saisiot.userinfo.dto.UserinfoDto;

@Repository
public class UserinfoDaoImpl implements UserinfoDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<UserinfoDto> selectList() {
		
		List<UserinfoDto> list = new ArrayList<UserinfoDto>();
		
		list = sqlSession.selectList(NAMESPACE + "selectList");
		
		
		return list;
	}

	@Override
	public UserinfoDto selectOne(String email) {
		
		UserinfoDto dto = new UserinfoDto();
		dto = sqlSession.selectOne(NAMESPACE + "selectOne", email);
		
		
		return dto;
	}

	@Override
	public int insert(UserinfoDto dto) {
		
		int res = 0;
		
		System.out.println(dto.getBirthdate());
		
		try {
		res = sqlSession.insert(NAMESPACE + "userinsert",dto);
		}catch(Exception e) {
			System.out.println("userinsert error");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int update(UserinfoDto dto) {
		
		int res = 0;
		
		res = sqlSession.update(NAMESPACE+"update",dto);
		
		return res;
	}

	@Override
	public int delete(String email) {
		
		int res = 0;
		
		res = sqlSession.delete(NAMESPACE + "delete" , email);
		
		return res;
	}

	@Override
	public UserinfoDto login(String email, String password) {
		
		UserinfoDto dto = new UserinfoDto(email,password);
		UserinfoDto res = dto;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "login", res);
		} catch (Exception e) {
			System.out.println("login error");
			e.printStackTrace();
		}
	
		return dto;
	}

	@Override
	public UserinfoDto kakaologin(String email, String password, String name) {
		
		UserinfoDto dto = new UserinfoDto(email, password, name);
		UserinfoDto res = dto;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "kakaologin", res);
		} catch (Exception e) {
			System.out.println("login error");
			e.printStackTrace();
		}
	
		return dto;
	}

	@Override
	public int kakaoinsert(UserinfoDto dto) {
		
		
		int res = 0;
		
		try {
		res = sqlSession.insert(NAMESPACE + "kakaoinsert",dto);
		}catch(Exception e) {
			System.out.println("userinsert error");
			e.printStackTrace();
		}
		
		return res;

	}

	@Override
	public int lastloginupdate(UserinfoDto dto) {

		int res = 0;
		
		res = sqlSession.update(NAMESPACE + "lastlogin", dto);
		
		return res;
	}

	@Override
	public UserinfoDto emailcheck(String email) {
		
		UserinfoDto dto = new UserinfoDto();
		dto = sqlSession.selectOne(NAMESPACE + "emailcheck", email);
		
		
		return dto;
	}

	@Override
	public UserinfoDto emailpwfind(String email) {
				
		UserinfoDto dto = new UserinfoDto(email);
	
		return sqlSession.selectOne(NAMESPACE + "emailpwfind" ,dto);
	}

	@Override
	public int passupdate(UserinfoDto dto) {
		
		int res = 0;
		
		res = sqlSession.update(NAMESPACE + "passupdate", dto);
		
		return res;
	}
	
	
	@Override
	public int longupdate(UserinfoDto dto) {
		
		System.out.println("휴면계정 업데이트");
		
		int res = 0;
		
		res = sqlSession.update(NAMESPACE + "longupdate", dto);
		
		return res;
	}
	
	@Override
	public List<UserinfoDto> longuser() {
		
		System.out.println("휴면계정 찾기");
		
		List<UserinfoDto> list = new ArrayList<UserinfoDto>();
		
		list = sqlSession.selectList(NAMESPACE + "longuser");
		
		return list;
	}

	@Override
	public int comebackuser(UserinfoDto dto) {
	System.out.println("계정 복귀");
		
		int res = 0;
		
		res = sqlSession.update(NAMESPACE + "comebackuser", dto);
		
		return res;
	}

	@Override
	public int snscomback(UserinfoDto dto) {
		
		int res = 0;
		
		res = sqlSession.update(NAMESPACE + "snscomeback", dto);
		
		return res;
	}

	@Override
	public int userinfoplus(UserinfoDto dto) {
		
		int res = 0;
		
		res = sqlSession.update(NAMESPACE + "userinfoplus", dto);
		
		return res;
	}


}
