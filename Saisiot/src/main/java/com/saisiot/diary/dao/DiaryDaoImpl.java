package com.saisiot.diary.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saisiot.diary.dto.DiaryDto;

@Repository
public class DiaryDaoImpl implements DiaryDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<DiaryDto> selectList() {
		
		List<DiaryDto> list = new ArrayList<DiaryDto>();
		
		list = sqlSession.selectList(NAMESPACE + "selectList_diary");
		
		return list;
	}
	
	

	@Override
	public void updateViewCnt(int diaryno) {
		sqlSession.update(NAMESPACE+"updateViewCnt", diaryno);
	}



	@Override
	public DiaryDto selectOne(int diaryno) {
		
		DiaryDto res = new DiaryDto();
		
		res = sqlSession.selectOne(NAMESPACE+"diary_detail",diaryno);
		
		return res;
	}

	@Override
	public int insert(DiaryDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"diary_insert",dto);
		} catch(Exception e) {
			System.out.println("diaryinsert error");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int update(DiaryDto dto) {
		return 0;
	}

	@Override
	public int delete(int diaryno) {
		return 0;
	}

}
