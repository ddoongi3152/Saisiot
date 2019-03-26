package com.saisiot.userinfo.biz;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.saisiot.userinfo.dto.UserinfoDto;

public interface UserinfoBiz {
	public List<UserinfoDto> selectList();
	public UserinfoDto selectOne(String email);
	public int insert(UserinfoDto dto);
	public int update(UserinfoDto dto);
	public int delete(String email);
	public UserinfoDto login(String email, String password);
	public UserinfoDto kakaologin(String email, String password, String name);
	public int kakaoinsert(UserinfoDto dto);
	public int lastloginupdate(UserinfoDto dto);
	public UserinfoDto emailcheck(String email);
	public UserinfoDto emailpwfind(String email);
	public int passupdate(UserinfoDto dto);
	public int longupdate(UserinfoDto dto);
	public List<UserinfoDto> longuser();
	public int comebackuser(UserinfoDto dto);
	public int snscomback(UserinfoDto dto);
	public int userinfoplus(UserinfoDto dto);

	// 중복 방문 방지를 위해 오늘 방문자 비교
	public String visit_overlap_check(Map visit_email);
	// 방문시, 방문자수 +1
	public void add_visit_count(Map visit_email);
	// 오늘의 방문자 수
	public int visit_today(Map visit_email);
	// 총 방문자 수
	public int visit_total(Map visit_email);
	// 일주일 간 방문자 수
	public List<Object> visit_weekdata(Map visit_email);
	
	//-------lee's editing---------------------
	public List<UserinfoDto> selectFriendList(String email);
	public String selectFriendOne(String email);
	public int friendInsert(String email1, String email2);
	public int friendUpdate(String email);
	public int friendDelete(String email);
	
}
