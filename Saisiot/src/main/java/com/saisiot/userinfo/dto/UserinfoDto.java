package com.saisiot.userinfo.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.saisiot.userinfo.security.SHA256;

public class UserinfoDto {
	
	private String email;
	private String password;
	private String gender;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date joindate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthdate;
	private String username;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date visitdate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date pwdate;
	private String addr;
	private int coinno;
	private int usercondition;
	
	public UserinfoDto() {
		super();
	}

	
	
	public UserinfoDto(String email, String password, String gender, Date joindate, Date birthdate, String username,
			Date visitdate, Date pwdate, String addr, int coinno, int usercondition) {
		super();
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.joindate = joindate;
		this.birthdate = birthdate;
		this.username = username;
		this.visitdate = visitdate;
		this.pwdate = pwdate;
		this.addr = addr;
		this.coinno = coinno;
		this.usercondition = usercondition;
	}



	public UserinfoDto(String email) {
		super();
		this.email = email;
	}

	public UserinfoDto(String email, String password) {
		super();
		this.email = email;
		this.password = password;
	}
	

	public UserinfoDto(String email, String password, String username) {
		super();
		this.email = email;
		this.password = password;
		this.username = username;
	}



	public UserinfoDto(Date visitdate) {
		super();
		this.visitdate = visitdate;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getGender() {
		return gender;
	}



	public void setGender(String gender) {
		this.gender = gender;
	}



	public Date getJoindate() {
		return joindate;
	}



	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}



	public Date getBirthdate() {
		return birthdate;
	}



	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public Date getVisitdate() {
		return visitdate;
	}



	public void setVisitdate(Date visitdate) {
		this.visitdate = visitdate;
	}



	public Date getPwdate() {
		return pwdate;
	}



	public void setPwdate(Date pwdate) {
		this.pwdate = pwdate;
	}



	public String getAddr() {
		return addr;
	}



	public void setAddr(String addr) {
		this.addr = addr;
	}



	public int getCoinno() {
		return coinno;
	}



	public void setCoinno(int coinno) {
		this.coinno = coinno;
	}



	public int getUsercondition() {
		return usercondition;
	}



	public void setUsercondition(int usercondition) {
		this.usercondition = usercondition;
	}


	
	
	
}