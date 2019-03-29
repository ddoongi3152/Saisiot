package com.saisiot.chat.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saisiot.chat.dao.ChatDao;
import com.saisiot.chat.dao.ChatDaoImpl;
import com.saisiot.chat.dto.ChatDto;

@Service
public class ChatBizImpl implements ChatBiz {
	
	

	public ChatBizImpl() {
	}

	@Autowired
	private ChatDao dao;
	
	@Override
	public List<ChatDto> selectChat(int relationno) {
		List<ChatDto> dtos = dao.selectChat(relationno);
		return dtos;
	}

	@Override
	public int insertChat(ChatDto dto) {
		int res = dao.insertChat(dto);
		return res;
	}

}
