package com.saisiot.diary.biz;

import java.util.List;

import com.saisiot.diary.dto.DiaryDto;

public interface DiaryBiz {
	
	public List<DiaryDto> selectList();
	public DiaryDto selectOne(int diaryno);
	public int insert(DiaryDto dto);
	public int update(DiaryDto dto);
	public int delete(int diaryno);

}
