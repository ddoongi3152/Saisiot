package com.saisiot.diary.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saisiot.diary.dto.DiaryDto;
import com.saisiot.diary.dto.DiaryRootDto;

@Repository
public class DiaryDaoImpl implements DiaryDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

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
	public List<DiaryDto> diarylist(int start, int end, String searchOption, String keyword,int folderno) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 검색 옵션, 키워드를 맵에저장
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		// BETWEEN #{start},#{end}에 입력될 값
		map.put("start", start);
		map.put("end", end);
		map.put("folderno", folderno);
		return sqlSession.selectList(NAMESPACE + "diarylist", map);
	}
	//게시글 카운트
	@Override
	public int countArticle(String searchOption, String keyword,int folderno) {
		// 검색옵션, 키워드 맵에 저장
		int res = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("folderno", folderno);
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


	//폴더 추가
	@Override
	public void folder_insert(DiaryRootDto dto) {
		sqlSession.insert(NAMESPACE+"folder_insert", dto);
	}

	//폴더 리스트 
	@Override
	public List<DiaryRootDto> folderList(String email) {
		List<DiaryRootDto> list = new ArrayList<DiaryRootDto>();
		list = sqlSession.selectList(NAMESPACE + "folderList",email);
		return list;
	}

	@Override
	public void folder_delete(int folderno) {
		sqlSession.delete(NAMESPACE+"folder_delete", folderno);
	}

	@Override
	public void folder_update(int folderno,String foldername) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("folderno", folderno);
		map.put("foldername", foldername);
		sqlSession.update(NAMESPACE+"folder_update", map);
	}
	
	

}
