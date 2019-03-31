package com.saisiot.diary.biz;

import java.util.List;

import com.saisiot.diary.dto.DiaryDto;
import com.saisiot.diary.dto.DiaryRootDto;

public interface DiaryBiz {

	public int insert(DiaryDto dto);
	public int update(DiaryDto dto);
	public int delete(int diaryno);
	
	// 게시글 전체 목록 ==> 검색옵션, 키워드 매개변수 추가
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword,int folderno);

	// 게시글 레코드 갯수
	public int countArticle(String searchOption, String keyword,int folderno);
	
	//댓글 리스트
	public List<DiaryDto> commentList();
	
	//댓글 업뎃&작성
	public void comment_insert_proc(DiaryDto dto,int diaryno);
	//댓글 삭제
	public void comment_delete(DiaryDto dto);
	
	public void folder_insert(DiaryRootDto dto);
	public void folder_delete(int folderno);
	public void folder_update(int folderno,String foldername);
	public List<DiaryRootDto> folderList(String email);
	
}
