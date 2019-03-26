package com.saisiot.profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.saisiot.profile.dto.ProfileDto;

@Controller
public class ProfileController {

	
	@RequestMapping("/profile.do")
	public String diary(Model model) {

		return "profile";
	}
	
	@RequestMapping("/addfriendpop.do")
	public String addfriendpop(Model model) {

		return "addfriend_pop";
	}
	
	@RequestMapping("/findfriend.do")
	public String addfriend(Model model) {
		
		return "addfriend";
	}

}
