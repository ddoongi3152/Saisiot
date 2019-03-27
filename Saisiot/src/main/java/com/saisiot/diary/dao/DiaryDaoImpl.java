package com.saisiot.diary.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public DiaryDto selectOne(int diaryno) {

		DiaryDto res = new DiaryDto();

		res = sqlSession.selectOne(NAMESPACE + "diary_detail", diaryno);

		return res;
	}

	@Override
	public int insert(DiaryDto dto) {

		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "diary_insert", dto);
		} catch (Exception e) {
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
	
	
	
	//다이어리 리스트
	@Override
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 검색 옵션, 키워드를 맵에저장
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		// BETWEEN #{start},#{end}에 입력될 값
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList(NAMESPACE + "diarylist", map);
	}
	//게시글 카운트
	@Override
	public int countArticle(String searchOption, String keyword) {
		// 검색옵션, 키워드 맵에 저장
		int res = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		res = sqlSession.selectOne(NAMESPACE + "countArticle", map);
		return res;
	}
	//commentlist 댓글 리스트
	@Override
	public List<DiaryDto> commentList() {
		List<DiaryDto> list = new ArrayList<DiaryDto>();
		list = sqlSession.selectList(NAMESPACE + "commentList");
		return list;
	}
	// 1. 댓글 업뎃
	@Override
	public int comment_update(int diaryno) {
		int res=sqlSession.insert(NAMESPACE +"comment_update", diaryno);
		return res;
	}
	//2. 댓글 입력
	@Override
	public void comment_insert(DiaryDto dto) {
		sqlSession.insert(NAMESPACE +"comment_insert", dto);
		
	}

	@Override
	public void comment_delete(DiaryDto dto) {
		sqlSession.delete(NAMESPACE+"comment_delete",dto);
	}

}
