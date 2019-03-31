package com.saisiot.profile.dto;

public class ProfileDto {
	
	private String email;
	private String p_picurl;
	private String p_content;
	private String p_title;
	
	public ProfileDto() {
		
	}
	
	public ProfileDto(String email, String p_picurl, String p_content, String p_title) {
		this.email = email;
		this.p_picurl = p_picurl;
		this.p_content = p_content;
		this.p_title = p_title;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getP_picurl() {
		return p_picurl;
	}
	public void setP_picurl(String p_picurl) {
		this.p_picurl = p_picurl;
	}
	public String getP_content() {
		return p_content;
	}
	public void setP_content(String p_content) {
		this.p_content = p_content;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}

}
