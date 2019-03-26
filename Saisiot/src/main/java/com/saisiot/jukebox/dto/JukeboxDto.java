package com.saisiot.jukebox.dto;

public class JukeboxDto {

	private int musicno;
	private String email;
	private String singer;
	private String musictitle;
	private String runtime;
	private String musicalbum;
	private String background;
	
	public JukeboxDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public JukeboxDto(int musicno, String email, String singer, String musictitle, String runtime, String musicalbum, String background) {
		super();
		this.musicno = musicno;
		this.email = email;
		this.singer = singer;
		this.musictitle = musictitle;
		this.runtime = runtime;
		this.musicalbum = musicalbum;
		this.background = background;
	}
	public int getMusicno() {
		return musicno;
	}
	public void setMusicno(int musicno) {
		this.musicno = musicno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSinger() {
		return singer;
	}
	public void setSinger(String singer) {
		this.singer = singer;
	}
	public String getBackground() {
		return background;
	}
	public void setBackground(String background) {
		this.background = background;
	}
	public String getMusictitle() {
		return musictitle;
	}
	public void setMusictitle(String musictitle) {
		this.musictitle = musictitle;
	}
	public String getRuntime() {
		return runtime;
	}
	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}
	public String getMusicalbum() {
		return musicalbum;
	}
	public void setMusicalbum(String musicalbum) {
		this.musicalbum = musicalbum;
	}
	
	
	
}
