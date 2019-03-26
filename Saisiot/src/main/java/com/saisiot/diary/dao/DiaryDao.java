package com.saisiot.diary.dao;

import java.util.List;

import com.saisiot.diary.dto.DiaryDto;

public interface DiaryDao {
	
	String NAMESPACE="customer.";
	
	public List<DiaryDto> selectList();
	public DiaryDto selectOne(int diaryno);
	public int insert(DiaryDto dto);
	public int update(DiaryDto dto);
	public int delete(int diaryno);
	public void updateViewCnt(int diaryno);

}
