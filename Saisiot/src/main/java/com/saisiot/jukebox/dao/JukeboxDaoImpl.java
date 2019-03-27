package com.saisiot.jukebox.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saisiot.jukebox.dto.JukeboxDto;

@Repository
public class JukeboxDaoImpl implements JukeboxDao {

	@Autowired
	private SqlSessionTemplate sqlSession; 
	
	@Override
	public List<JukeboxDto> jukeselect(String email) {
		
		List<JukeboxDto> res = new ArrayList<JukeboxDto>();
		res = sqlSession.selectList(namespace+"jukeselect", email);
		
		return res;
	}

	@Override
	public int insert(JukeboxDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(namespace + "insertSong", dto);
		} catch (Exception e) {
			System.out.println("insertSong error");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int updateBack(JukeboxDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.update(namespace + "updateBack", dto);
		} catch (Exception e) {
			System.out.println("updateBack error");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<JukeboxDto> backselect(String email, String background) {
		List<JukeboxDto> list = new ArrayList<JukeboxDto>();
		JukeboxDto dto = new JukeboxDto(0, email, null, null, null, null, background);
		list = sqlSession.selectList(namespace + "backselect", dto);
		
		return list;
	}

}
