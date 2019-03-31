package com.saisiot.jukebox;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.saisiot.common.ManiaDB;
import com.saisiot.jukebox.dao.JukeboxDao;
import com.saisiot.jukebox.dto.JukeboxDto;
import com.saisiot.userinfo.biz.UserinfoBiz;
import com.saisiot.userinfo.biz.UserinfoBizImpl;
import com.saisiot.userinfo.dto.UserinfoDto;

@Controller
public class JukeboxController {
	
	@Autowired
	private UserinfoBizImpl biz;
	
	@Autowired
	private JukeboxDao jukedao;

	//쥬크박스
	
	@RequestMapping("/gallery.do")
	public String gallery() {
		
		return "gallery";
	}
	
	@RequestMapping("/searchMusic.do")
	@ResponseBody
	public Map<Integer,Map<String, String>> searchMusic(String name) {
		ManiaDB mt = new ManiaDB();
		Map<Integer,Map<String, String>> mp = new HashMap<Integer, Map<String,String>>();
		mp = mt.maniaDb(name);

		return mp;
	}
	
	@RequestMapping("/jukebox.do")
	public String jukeboxList(Model model, String email) {
		List<JukeboxDto> list = new ArrayList<JukeboxDto>();
		
		list = jukedao.jukeselect(email);
		model.addAttribute("jukelist", list);
		
		return "jukebox";
	}
	
	@RequestMapping("/buysong.do")
	public ModelAndView buySong(String email, String songOne, HttpSession session, HttpServletResponse response) throws IOException {

		UserinfoDto userdto = (UserinfoDto)session.getAttribute("login");
		int coin = userdto.getCoinno();
		
		if((coin-5) < 0 || coin <= 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			System.out.println("프로필-구매로 보내기");
			out.println("<script>alert('잔여 도토리가 부족합니다. 도토리를 충전해주세요.');</script>");
			out.flush();
			String url = "forward:profile.do";
			return new ModelAndView(url);
		}else {
			userdto = new UserinfoDto(email, null, null, null, null, null, null, null, null, (coin-5), 0);
			int coinres = biz.coinupdate(userdto);
			String url = "redirect:jukebox.do?email="+email;
			if(coinres > 0) {
				String[] songArr = songOne.split("#");
				JukeboxDto dto = new JukeboxDto(0,email, songArr[0], songArr[1], songArr[2], songArr[3],"N");
				
				int res = 0;
				res = jukedao.insert(dto);
				if(res > 0) {
					return new ModelAndView(url);
				}else {
					System.out.println("구매 실패");
					return new ModelAndView(url);
				}
			}else {
				System.out.println("구매 실패");
				return new ModelAndView(url);
			}
		}
		
	}
	
	@RequestMapping("/updateBack.do")
	public String backgroundMusic(HttpSession session, String email, String[] chk, String[] unchk) {
		int res = 1;
		if(unchk == null||unchk.length == 0) {
			if(chk != null && chk.length != 0) {
				for(int i = 0; i < chk.length; i++) {
					JukeboxDto dto = new JukeboxDto(Integer.parseInt(chk[i]), email, null, null, null, null, "Y");
					jukedao.updateBack(dto);
					res++;
				}
			}
			String setBackground = setBackground(session, email);
			return setBackground;
			
		}else {
			for(int i = 0; i < unchk.length; i++) {
				JukeboxDto dto = new JukeboxDto(Integer.parseInt(unchk[i]), email, null, null, null, null, "N");
				jukedao.updateBack(dto);
				res++;
			}
			if(chk == null || chk.length == 0) {
				System.out.println("alert로 알리기");
				String setBackground = setBackground(session, email);
				return setBackground;
			}else {
				for(int i = 0; i < chk.length; i++) {
					JukeboxDto dto = new JukeboxDto(Integer.parseInt(chk[i]), email, null, null, null, null, "Y");
					jukedao.updateBack(dto);
					res++;
				}
				if(res == (chk.length+unchk.length)) {
					System.out.println("배경음악 저장 성공");
					String setBackground = setBackground(session, email);
					return setBackground;
				}else {
					System.out.println("배경음악 저장 실패");
					String setBackground = setBackground(session, email);
					return setBackground;
				}
			}
		}
	}
	
	// session에 배경음악 재설정
	public String setBackground(HttpSession session, String email) {
		List<JukeboxDto> jukelist = new ArrayList<JukeboxDto>();
		jukelist = jukedao.backselect(email, "Y");

		if(jukelist==null) {
			return "redirect:jukebox.do?email="+email;
		}else {
			session.removeAttribute("background");
			session.setAttribute("background",jukelist);
			return "redirect:jukebox.do?email="+email;
		}
	}
}
