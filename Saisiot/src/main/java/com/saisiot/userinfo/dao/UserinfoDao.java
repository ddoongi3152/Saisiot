package com.saisiot.userinfo.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.saisiot.profile.dto.ProfileDto;
import com.saisiot.userinfo.dto.UserinfoDto;


public interface UserinfoDao {

	String NAMESPACE="userinfo.";
	
	public List<UserinfoDto> selectList();
	
	// 아이디 1개 선택할 경우
	public UserinfoDto selectOne(String email);
	public int insert(UserinfoDto dto);
	public int update(UserinfoDto dto);
	// 유저 삭제
	public int delete(String email);
	// 로그인
	public UserinfoDto login(String email, String password);
	// 소셜로그인
	public UserinfoDto kakaologin(String email, String password, String name);
	// 소셜 로그인 회원가입
	public int kakaoinsert(UserinfoDto dto);
	// 마지막 로그인 시간 업데이트
	public int lastloginupdate(UserinfoDto dto);
	// 이메일 중복 체크
	public UserinfoDto emailcheck(String email);
	// 이메일 -> 비밀번호 초기화
	public UserinfoDto emailpwfind(String email);
	// 비밀번호 변경
	public int passupdate(UserinfoDto dto);
	// 휴면계정으로 전환
	public int longupdate(UserinfoDto dto);
	// 휴면계정 대상자 찾기
	public List<UserinfoDto> longuser();
	// 복귀 계정 비밀번호 변경 및 상태변경
	public int comebackuser(UserinfoDto dto);
	// 소셜 복귀계정 상태변경
	public int snscomback(UserinfoDto dto);
	// 소셜 로그인 유저 추가정보 입력
	public int userinfoplus(UserinfoDto dto);
	// 비밀번호 초기화 유저 비밀번호 변경
	public int passreset(UserinfoDto dto);
	// 유저 이용 정지
	public int userstop(UserinfoDto dto);
	// 유저 이용 복귀
	public int usercome(UserinfoDto dto);


	//-----------------lee's editing
	
	public List<UserinfoDto> selectFriendList(String email);
	public List<UserinfoDto> selectFriendDto(List<String> friendList);
	public int friendInsert(String emailFriend, String emailMe);
	public int selectRoom(String emailFriend, String emailMe);
	public int friendDelete(String email);

	//유정
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

	public int coinupdate(UserinfoDto dto);

	//------------------lee's editing end
	
	// cheon's editing-------
	public int insert_P(UserinfoDto dto);

	public int update_p(ProfileDto pdto);

	public ProfileDto select_p(String email);
	// cheon's editing end ---

	// 개인정보 수정(seo)
	public int update_personal(UserinfoDto dto);

}
