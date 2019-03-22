package com.saisiot.chat;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.saisiot.userinfo.dto.UserinfoDto;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ChatController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
/*	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}*/
	
	@RequestMapping(value="/chat.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String chat(Model model, HttpSession session) {
		
		UserinfoDto dto = (UserinfoDto) session.getAttribute("login");
		session.setAttribute("login", dto);
		
		return "chat";
	}
	@RequestMapping(value="/diary.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String diary(Locale locale, Model model) {
		return "diary";
	}
}