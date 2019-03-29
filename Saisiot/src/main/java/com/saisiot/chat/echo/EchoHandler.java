
package com.saisiot.chat.echo;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.saisiot.chat.biz.ChatBiz;
import com.saisiot.chat.biz.ChatBizImpl;
import com.saisiot.chat.dto.ChatDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;

public class EchoHandler extends TextWebSocketHandler {
	  private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	  private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	 
	  @Autowired
	  private ChatBiz biz;
	  // after connect
	  @Override
	  public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    sessionList.add(session);
	  }
	 
	  // after client send to server
	  @Override
	  protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    for (WebSocketSession sess : sessionList) {
	    	String rawmessage =message.getPayload();
	    	JSONParser parser = new JSONParser();
	    	JSONObject jobj = (JSONObject)parser.parse(rawmessage);
	    	String email = (String) jobj.get("id");
	    	String chattext = (String) jobj.get("text");
	    	int relationno = Integer.parseInt((String) jobj.get("roomno"));
	    	ChatDto dto = new ChatDto(relationno, email, chattext);
	    	System.out.println(dto.getRelationno()+ dto.getEmail()+dto.getChattext());
	    	int res = biz.insertChat(dto);
	    	
    		if(res==1) {
	  	      	sess.sendMessage(new TextMessage(rawmessage));
	    	}else {
	    		sess.sendMessage(new TextMessage("오류:메세지가 저장되지 않았습니다 : "+rawmessage));
	    	}
	    }
	  }
	 
	  // after client disconnected
	  @Override
	  public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    sessionList.remove(session);
	  }
	}
