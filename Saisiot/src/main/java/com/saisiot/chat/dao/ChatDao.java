package com.saisiot.chat.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.saisiot.chat.dto.ChatDto;

public interface ChatDao {
	
	String NAMESPACE="chat.";
	
	public List<ChatDto> selectChat(int relationno);
	public int insertChat(ChatDto dto);

}
