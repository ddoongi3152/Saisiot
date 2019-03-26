package com.saisiot.profile;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ProfileController {

	
	@RequestMapping("/profile.do")
	public String diary(Model model) {

		return "profile";
	}

}