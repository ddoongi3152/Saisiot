package com.saisiot.chat.echo;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.JsonParser;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;

public class EchoHandler extends TextWebSocketHandler {
	  private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	  private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	 
	  // 클라이언트와 연결 이후에 실행되는 메서드
	  @Override
	  public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    sessionList.add(session);
	  }
	 
	  // 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	  @Override
	  protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    for (WebSocketSession sess : sessionList) {
	    	JSONObject jobj = new JSONObject();
<<<<<<< HEAD
	    	JsonParser parser = new JsonParser();
=======
>>>>>>> refs/heads/master
	      sess.sendMessage(new TextMessage(message.getPayload()));
	    }
	  }
	 
	  // 클라이언트와 연결을 끊었을 때 실행되는 메소드
	  @Override
	  public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    sessionList.remove(session);
	  }
	}
