package com.saisiot.diary.dto;

import java.util.Date;

public class DiaryDto {

	private Integer diaryno;
	private Integer folderno;
	private String title;
	private String content;
	private Date regdate;
	private String fileurl;
	private String picurl;
	private String mapname;
	private Float maplati;
	private Float maplong;
	private String videourl;
	private Integer viewtime;
	private Integer groupno;
	private Integer groupsq;
<<<<<<< HEAD

=======
	
	
>>>>>>> refs/remotes/origin/master
	public DiaryDto() {
		super();
	}

	
	public DiaryDto(Integer diaryno, Integer folderno, String title, String content, Date regdate, String fileurl,
<<<<<<< HEAD
			String picurl, String mapname, Float maplati, Float maplong, String videourl, Integer viewtime,
			Integer groupno, Integer groupsq) {
=======
			String picurl, Float maplati, Float maplong, String videourl, Integer viewtime, Integer groupno,
			Integer groupsq) {
>>>>>>> refs/remotes/origin/master
		super();
		this.diaryno = diaryno;
		this.folderno = folderno;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.fileurl = fileurl;
		this.picurl = picurl;
		this.mapname = mapname;
		this.maplati = maplati;
		this.maplong = maplong;
		this.videourl = videourl;
		this.viewtime = viewtime;
		this.groupno = groupno;
		this.groupsq = groupsq;
	}

<<<<<<< HEAD
=======

	public Integer getGroupno() {
		return groupno;
	}


	public void setGroupno(Integer groupno) {
		this.groupno = groupno;
	}


	public Integer getGroupsq() {
		return groupsq;
	}


	public void setGroupsq(Integer groupsq) {
		this.groupsq = groupsq;
	}


>>>>>>> refs/remotes/origin/master
	public Integer getDiaryno() {
		return diaryno;
	}

	public void setDiaryno(Integer diaryno) {
		this.diaryno = diaryno;
	}

	public Integer getFolderno() {
		return folderno;
	}

	public void setFolderno(Integer folderno) {
		this.folderno = folderno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getFileurl() {
		return fileurl;
	}

	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}

	public String getPicurl() {
		return picurl;
	}

	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

	public Float getMaplati() {
		return maplati;
	}

	public void setMaplati(Float maplati) {
		this.maplati = maplati;
	}

	public Float getMaplong() {
		return maplong;
	}

	public void setMaplong(Float maplong) {
		this.maplong = maplong;
	}

	public String getVideourl() {
		return videourl;
	}

	public void setVideourl(String videourl) {
		this.videourl = videourl;
	}

	public Integer getViewtime() {
		return viewtime;
	}

	public void setViewtime(Integer viewtime) {
		this.viewtime = viewtime;
	}

	public String getMapname() {
		return mapname;
	}

	public void setMapname(String mapname) {
		this.mapname = mapname;
	}

	public Integer getGroupno() {
		return groupno;
	}

	public void setGroupno(Integer groupno) {
		this.groupno = groupno;
	}

	public Integer getGroupsq() {
		return groupsq;
	}

	public void setGroupsq(Integer groupsq) {
		this.groupsq = groupsq;
	}

}
