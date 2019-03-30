package com.saisiot.chat.biz;

import java.util.List;

import com.saisiot.chat.dto.ChatDto;


public interface ChatBiz {
	
	public List<ChatDto> selectChat(int relationno);
	public int insertChat(ChatDto dto);
}
