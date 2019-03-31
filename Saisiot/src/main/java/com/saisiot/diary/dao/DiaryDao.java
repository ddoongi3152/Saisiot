package com.saisiot.diary.dao;

import java.util.List;

import com.saisiot.diary.dto.DiaryDto;
import com.saisiot.diary.dto.DiaryRootDto;

public interface DiaryDao {
	
	String NAMESPACE="diary.";
	
	public int insert(DiaryDto dto);
	public int update(DiaryDto dto);
	public int delete(int diaryno);
	
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword,int folderno);
	public int countArticle(String searchOption, String keyword,int folderno);
	public List<DiaryDto> commentList();
	public int comment_update(int diaryno);
	public void comment_insert(DiaryDto dto);
	public void comment_delete(DiaryDto dto);
	

	public void folder_insert(DiaryRootDto dto);
	public void folder_delete(int folderno);
	public void folder_update(int folderno,String foldername);
	public List<DiaryRootDto> folderList(String email);
	
}
