package com.saisiot.diary.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saisiot.diary.dao.DiaryDao;
import com.saisiot.diary.dto.DiaryDto;

@Service
public class DiaryBizImpl implements DiaryBiz {

	@Autowired
	private DiaryDao dao;
	
	@Override
	public List<DiaryDto> selectList() {
		
		return dao.selectList();
	}

	@Override
	public DiaryDto selectOne(int diaryno) {
		dao.updateViewCnt(diaryno);
		return dao.selectOne(diaryno);
	}

	@Override
	public int insert(DiaryDto dto) {
		return dao.insert(dto);
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
