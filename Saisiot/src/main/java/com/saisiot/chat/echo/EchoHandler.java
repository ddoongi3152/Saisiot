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
	 
	  // Ŭ���̾�Ʈ�� ���� ���Ŀ� ����Ǵ� �޼���
	  @Override
	  public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    sessionList.add(session);
	  }
	 
	  // Ŭ���̾�Ʈ�� ������ �޽����� �������� �� ����Ǵ� �޼���
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
	 
	  // Ŭ���̾�Ʈ�� ������ ������ �� ����Ǵ� �޼ҵ�
	  @Override
	  public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    sessionList.remove(session);
	  }
	}
