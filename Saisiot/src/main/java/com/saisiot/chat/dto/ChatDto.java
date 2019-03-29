package com.saisiot.chat.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ChatDto {
	
	private int chatno;
	private int relationno;
	private String email;
	private String chattext;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd-HH-mm")
	private Date chatdate;
	
	public ChatDto() {};

	public ChatDto(int chatno, int relationno, String email, String chattext, Date chatdate) {

		this.chatno = chatno;
		this.relationno = relationno;
		this.email = email;
		this.chattext = chattext;
		this.chatdate = chatdate;
	}
	public ChatDto(int relationno, String email, String chattext) {
		this.relationno = relationno;
		this.email = email;
		this.chattext = chattext;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getChatno() {
		return chatno;
	}
	public void setChatno(int chatno) {
		this.chatno = chatno;
	}
	public int getRelationno() {
		return relationno;
	}
	public void setRelationno(int relationno) {
		this.relationno = relationno;
	}
	public String getChattext() {
		return chattext;
	}
	public void setChattext(String chattext) {
		this.chattext = chattext;
	}
	public Date getChatdate() {
		return chatdate;
	}
	public void setChatdate(Date chatdate) {
		this.chatdate = chatdate;
	}
}
