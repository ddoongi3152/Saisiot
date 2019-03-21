package com.saisiot.jukebox.dao;

import java.util.List;

import com.saisiot.jukebox.dto.JukeboxDto;

public interface JukeboxDao {

	String namespace = "userinfo.";
	
	public List<JukeboxDto> jukeselect(String email);
	public List<JukeboxDto> backselect(String email, String background);
	public int insert(JukeboxDto dto);
	public int updateBack(JukeboxDto dto);
	
	
	
}
