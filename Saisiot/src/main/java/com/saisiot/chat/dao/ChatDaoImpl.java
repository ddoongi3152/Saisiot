package com.saisiot.chat.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saisiot.chat.dto.ChatDto;

@Repository
public class ChatDaoImpl implements ChatDao {

	
	
	public ChatDaoImpl() {
		System.out.println("ChatDaoImpl Constructing");
	}

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ChatDto> selectChat(int relationno) {
		
		List<ChatDto> dtos = sqlSession.selectList(NAMESPACE + "select_chat", relationno);
		
		return dtos;
	}

	@Override
	public int insertChat(ChatDto dto) {

		int res = sqlSession.insert(NAMESPACE + "insert_chat",dto);
		return res;
	}

}
