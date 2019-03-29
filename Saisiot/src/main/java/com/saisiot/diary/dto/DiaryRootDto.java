package com.saisiot.diary.dto;

public class DiaryRootDto {

	private Integer folderno;
	private String email;
	private String foldername;
	private Integer foldersq;
	
	public DiaryRootDto(Integer folderno, String email, String foldername, Integer foldersq) {
		super();
		this.folderno = folderno;
		this.email = email;
		this.foldername = foldername;
		this.foldersq = foldersq;
	}

	public Integer getFolderno() {
		return folderno;
	}

	public void setFolderno(Integer folderno) {
		this.folderno = folderno;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFoldername() {
		return foldername;
	}

	public void setFoldername(String foldername) {
		this.foldername = foldername;
	}

	public Integer getFoldersq() {
		return foldersq;
	}

	public void setFoldersq(Integer foldersq) {
		this.foldersq = foldersq;
	}
	
	
}
