package com.saisiot.diary.dao;

import java.util.List;

import com.saisiot.diary.dto.DiaryDto;
import com.saisiot.diary.dto.DiaryRootDto;

public interface DiaryDao {
	
	String NAMESPACE="diary.";
	
	public int insert(DiaryDto dto);
	public int update(DiaryDto dto);
	public int delete(int diaryno);
	
	public void folder_insert(DiaryRootDto dto);
	public List<DiaryRootDto> folderList();
	
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword);
	public int countArticle(String searchOption, String keyword);
	public List<DiaryDto> commentList();
	public int comment_update(int diaryno);
	public void comment_insert(DiaryDto dto);
	public void comment_delete(DiaryDto dto);
	
}
