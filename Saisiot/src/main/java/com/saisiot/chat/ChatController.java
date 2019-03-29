package com.saisiot.chat;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saisiot.chat.biz.ChatBiz;
import com.saisiot.chat.dto.ChatDto;
import com.saisiot.userinfo.biz.UserinfoBiz;
import com.saisiot.userinfo.dto.UserinfoDto;



/**
 * Handles requests for the application home page.
 */
@Controller
public class ChatController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Autowired
	UserinfoBiz u_biz;
	@Autowired
	ChatBiz c_biz;

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

		List<UserinfoDto> friendList = u_biz.selectFriendList(dto.getEmail());
		session.setAttribute("friendList", friendList);

		session.setAttribute("login", dto);
		
		return "chat";
	}
	

	@ResponseBody
	@RequestMapping(value="/chatroomno.do", method= {RequestMethod.GET, RequestMethod.POST})
	public int chatroomno(Model model, HttpSession session, HttpServletRequest request) {
		
		UserinfoDto dto = (UserinfoDto) session.getAttribute("login");
		String emailMe = dto.getEmail();
		String emailFriend = request.getParameter("email");
		int roomno = u_biz.selectRoom(emailFriend, emailMe);
		return roomno;
	}
	
	@ResponseBody
	@RequestMapping(value="/chatroominit.do", method= {RequestMethod.GET, RequestMethod.POST}, produces = "application/text; charset=utf8")
	public String chatroomInit(Model model, HttpSession session, HttpServletRequest request) {

		int relationno = Integer.parseInt(request.getParameter("chatroomno"));
		List<ChatDto> dtos = c_biz.selectChat(relationno);
		
		
		JSONArray jarr = new JSONArray();
		for(ChatDto dto : dtos) {
			JSONObject jobj = new JSONObject();
			jobj.put("id", dto.getEmail());
			jobj.put("text", dto.getChattext());
			jobj.put("chatdate", ""+dto.getChatdate());
			jarr.add(jobj);
		}
		JSONObject jarrobj = new JSONObject();
		jarrobj.put("messages", jarr);
		String sjarr = jarrobj.toJSONString();

		return sjarr;
	}
	

}
