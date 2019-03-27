package com.saisiot.profile;

import com.saisiot.userinfo.biz.UserinfoBiz;
import com.saisiot.userinfo.dto.UserinfoDto;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ProfileController {

	@Autowired
	UserinfoBiz biz;
	
	@RequestMapping("/profile.do")
	public String diary(Model model, HttpSession session) {

		UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
		String email  = dto.getEmail();
		List<UserinfoDto> friendList = biz.selectFriendList(email);
		session.setAttribute("friendList", friendList);
		
		return "profile";
	}
	
	@RequestMapping("/addfriendpop.do")
	public String addFriendpop(Model model) {

		return "addfriend_pop";
	}
	
	//ajax
	@ResponseBody
	@RequestMapping(value = "/findfriend.do" , method = {RequestMethod.POST})
	public String findFriend(Model model, String email) {
		
		System.out.println("findfriend: email ==========="+email);
		UserinfoDto dto = biz.selectOne(email);
		String username = dto.getUsername();
		return username;
	}
	//ajax
	@ResponseBody
	@RequestMapping(value = "/insertfriend.do" , method = {RequestMethod.POST})
	public int insertFriend(Model model, String email, HttpSession session) {
		
		System.out.println("insertfriend: email ==========="+email);
		String emailFriend = email;
		UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
		String emailMe = dto.getEmail();
		int res= biz.friendInsert(emailFriend, emailMe);

		return res;
	}

}
