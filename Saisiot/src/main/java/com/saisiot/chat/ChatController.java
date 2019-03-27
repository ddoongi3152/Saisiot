package com.saisiot.chat;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.saisiot.userinfo.biz.UserinfoBiz;
import com.saisiot.userinfo.dto.UserinfoDto;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ChatController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Autowired
	UserinfoBiz biz;
	
	@RequestMapping(value="/chat.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String chat(Model model, HttpSession session) {
		
		UserinfoDto dto = (UserinfoDto) session.getAttribute("login");
		List<UserinfoDto> friendList = biz.selectFriendList(dto.getEmail());
		session.setAttribute("friendList", friendList);
		return "chat";
	}
	
	


}
