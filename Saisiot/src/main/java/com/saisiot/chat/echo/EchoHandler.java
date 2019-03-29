
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
	 
	  // after connect
	  @Override
	  public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    sessionList.add(session);
	  }
	 
	  // after client send to server
	  @Override
	  protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    for (WebSocketSession sess : sessionList) {
	    	JSONObject jobj = new JSONObject();
	      sess.sendMessage(new TextMessage(message.getPayload()));
	    }
	  }
	 
	  // after client disconnected
	  @Override
	  public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    sessionList.remove(session);
	  }
	}
