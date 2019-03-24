package com.saisiot.diary.biz;

import java.util.List;

import com.saisiot.diary.dto.DiaryDto;

public interface DiaryBiz {

	public List<DiaryDto> selectList();
	public DiaryDto selectOne(int diaryno);
	public int insert(DiaryDto dto);
	public int update(DiaryDto dto);
	public int delete(int diaryno);

	// 게시글 전체 목록 ==> 검색옵션, 키워드 매개변수 추가
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword);

	// 게시글 레코드 갯수
	public int countArticle(String searchOption, String keyword);
	
	//댓글 리스트
	public List<DiaryDto> commentList();
	
	//
	public void comment_insert_proc(DiaryDto dto,int diaryno);
}
