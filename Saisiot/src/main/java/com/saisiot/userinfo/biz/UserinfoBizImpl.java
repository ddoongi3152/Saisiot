package com.saisiot.userinfo.biz;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.saisiot.profile.dto.ProfileDto;
import com.saisiot.userinfo.dao.UserinfoDao;
import com.saisiot.userinfo.dto.UserinfoDto;

@Service
public class UserinfoBizImpl implements UserinfoBiz {

	@Autowired
	private UserinfoDao dao;
	
	@Override
	public List<UserinfoDto> selectList() {

		return dao.selectList();
	}

	@Override
	public UserinfoDto selectOne(String email) {

		return dao.selectOne(email);
	}

	@Override
	public int insert(UserinfoDto dto) {

		return dao.insert(dto);
	}

	@Override
	public int update(UserinfoDto dto) {

		return dao.update(dto);
	}

	@Override
	public int delete(String email) {

		return dao.delete(email);
	}

	@Override
	public UserinfoDto login(String email, String password) {
		// TODO Auto-generated method stub
		return dao.login(email, password);
	}

	@Override
	public UserinfoDto kakaologin(String email, String password, String name) {
		// TODO Auto-generated method stub
		return dao.kakaologin(email, password, name);
	}

	@Override
	public int kakaoinsert(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.kakaoinsert(dto);
	}


	@Override
	public int lastloginupdate(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.lastloginupdate(dto);
	}

	@Override
	public UserinfoDto emailcheck(String email) {
		// TODO Auto-generated method stub
		return dao.emailcheck(email);
	}

	@Override
	public UserinfoDto emailpwfind(String email) {
		// TODO Auto-generated method stub
		return dao.emailpwfind(email);
	}

	@Override
	public int passupdate(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.passupdate(dto);
	}

	@Override
	public int longupdate(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.longupdate(dto);
	}

	@Override
	public List<UserinfoDto> longuser() {
		// TODO Auto-generated method stub
		return dao.longuser();
	}
	@Override
	public int passreset(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.passreset(dto);
	}
	
	//---lee's editing-------------------------------------------------
	@Override
	public List<UserinfoDto> selectFriendList(String email) {
		return dao.selectFriendList(email);
	}

	@Override
	public String selectFriendOne(String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int friendInsert(String emailFriend, String emailMe) {
		// TODO Auto-generated method stub
		return dao.friendInsert(emailFriend, emailMe);
	}

	@Override
	public int selectRoom(String emailFriend, String emailMe) {
		return dao.selectRoom(emailFriend, emailMe);
	}
	@Override
	public int friendDelete(String email) {
		// TODO Auto-generated method stub
		return 0;
	}
	//---lee's editing end----------------------------------------------
		
	//seo's editing------------------
	@Override
	public String visit_overlap_check(Map visit_email) {
		// TODO Auto-generated method stub
		return dao.visit_overlap_check(visit_email);
	}

	@Override
	public void add_visit_count(Map visit_email) {
		// TODO Auto-generated method stub
		dao.add_visit_count(visit_email);
	}

	@Override
	public int visit_today(Map visit_email) {
		// TODO Auto-generated method stub
		return dao.visit_today(visit_email);
	}

	@Override
	public int visit_total(Map visit_email) {
		// TODO Auto-generated method stub
		return dao.visit_total(visit_email);
	}

	@Override
	public List<Object> visit_weekdata(Map visit_email) {
		// TODO Auto-generated method stub
		return dao.visit_weekdata(visit_email);
	}
	public int coinupdate(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.coinupdate(dto);
	}
	//seo's editing end----------

	@Override
	public int comebackuser(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.comebackuser(dto);
	}

	@Override
	public int snscomback(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.snscomback(dto);
	}

	@Override
	public int userinfoplus(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.userinfoplus(dto);
	}

	@Override
	public int userstop(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.userstop(dto);
	}

	@Override
	public int usercome(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.usercome(dto);
	}

	

	public int update_personal(UserinfoDto dto) {
		// TODO Auto-generated method stub
		return dao.update_personal(dto);
	}

	// cheon's editing------------
	@Override
	public int insert_P(UserinfoDto dto) {
		return dao.insert_P(dto);
	}

	@Override
	public int update_p(ProfileDto Pdto) {
		return dao.update_p(Pdto);
	}

	@Override
	public ProfileDto select_p(String email) {
		return dao.select_p(email);
	}

	// cheon's editing end---------
		
		

	
	
	

}

/*
 * @Transaction (tx:)
 * --isolation : 별도로 정의하지 않으면 DB의 isolation level을 따른다.
 * --default : 데이터베이스에 의존
 * --uncommitted : commit 되지 않은 데이터를 볼 수 있다.
 * --commited : commit된 데이터만 볼 수 있다.
 * --repeatable : 새로운 데이터 입력 시 볼 수 있다.
 * --serializable : 동일한 데이터에 동시에 두 개 이상의 트랜잭션이 수행 될 수 없다.
 * 
 * --propagation : 전파 규칙정의 (기본값 : required)
 * --required : 기존 트랜잭션이 존재하면 지원, 없으면 새로운 트랜잭션 시작
 * --supports : 기족 트랜잭션이 존재하면 지원, 없으면 트랜잭션없이
 * --mandatory : 반드시 트랜잭션 내에서 메소드 실행, 없으면 예외 발생
 * -required_new : 언제나 새로운 트랜잭션 실행.
 * 기존 트랜잭션 일시정지
 * --not_supported : 기존 트랙잭션 내에서 실행.
 * 없으면 트랜잭션 없이
 * --never : mandatory와 반대 (반드시 트랜잭션 외부에서 실행)
 * --nested : 트랜잭션이 존재하면 중첩되어 실행, 없으면 새로운 트랜잭션 시작
 * 
 * -readOnly : 읽기 전용
 * -rollbackFor : 정의된 exception에 대해선 rollback 수행
 * -norollbackFor : 정의된 exception에 대해선 rollback x
 * -timeout : 지정한 시간 내에 메소드 수행 완료되지 않으며 rollback. (기본값 : -1 // no timeout)
 * --mybatis에서 timeout 존재하면 중첩되어 실행. 없으면 새로운 트랜잭션 시작
 * 
 */
