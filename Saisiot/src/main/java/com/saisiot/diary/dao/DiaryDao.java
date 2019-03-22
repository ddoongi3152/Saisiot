package com.saisiot.diary.dao;

import java.util.List;

import com.saisiot.diary.dto.DiaryDto;

public interface DiaryDao {
	
	String NAMESPACE="diary.";
	
	public List<DiaryDto> selectList();
	public DiaryDto selectOne(int diaryno);
	public int insert(DiaryDto dto);
	public int update(DiaryDto dto);
	public int delete(int diaryno);
	
	
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword);
	public int countArticle(String searchOption, String keyword);

}
