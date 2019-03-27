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

	//검색 조건 리스트
	@Override
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword) {
		// TODO Auto-generated method stub
		return dao.diarylist(start, end, searchOption, keyword);
	}
	
	// 게시글 레코드 갯수
	@Override
	public int countArticle(String searchOption, String keyword) {
		return dao.countArticle(searchOption, keyword);
	}
	// 댓글 리스트
	@Override
	public List<DiaryDto> commentList() {
		return dao.commentList();
	}
	@Override
	public void comment_insert_proc(DiaryDto dto,int diaryno) {
		//부모 번호
		int parent_diaryno=diaryno;
		//글 순서 업뎃
		int comment_update=dao.comment_update(parent_diaryno);
		//글 입력
		dao.comment_insert(dto);

		/*return ((insertdto + comment_update) > 0) ? 1 : 0;*/
		
		
	}

	@Override
	public void comment_delete(DiaryDto dto) {
		dao.comment_delete(dto);
	}
	

}
