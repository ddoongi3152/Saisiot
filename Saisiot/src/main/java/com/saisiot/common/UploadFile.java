package com.saisiot.common;

import org.springframework.web.multipart.MultipartFile;

public class UploadFile {
	
	private String filename;
	private String desc;
	private MultipartFile file;
	private Integer folderno;
	private String title;
	private String content;
	private String fileurl;
	private String picurl;
	private Float maplati;
	private Float maplong;
	private String videourl;
	
	
	public Integer getFolderno() {
		return folderno;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public String getFileurl() {
		return fileurl;
	}
	public String getPicurl() {
		return picurl;
	}
	public Float getMaplati() {
		return maplati;
	}
	public Float getMaplong() {
		return maplong;
	}
	public String getVideourl() {
		return videourl;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getDesc() {
		return desc;
	}
	public void setFolderno(Integer folderno) {
		this.folderno = folderno;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public void setMaplati(Float maplati) {
		this.maplati = maplati;
	}
	public void setMaplong(Float maplong) {
		this.maplong = maplong;
	}
	public void setVideourl(String videourl) {
		this.videourl = videourl;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	

}
