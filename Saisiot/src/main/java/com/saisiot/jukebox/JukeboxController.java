package com.saisiot.jukebox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saisiot.jukebox.dao.JukeboxDao;
import com.saisiot.jukebox.dto.JukeboxDto;
import com.saisiot.common.ManiaDB;

@Controller
public class JukeboxController {
	
	@Autowired
	private JukeboxDao jukedao;

	//쥬크박스
	
	@RequestMapping("/gallery.do")
	public String gallery() {
		
		return "gallery";
	}
	
	@RequestMapping("/searchMusicForm.do")
	public String searchMusicForm() {
		
		return "searchMusic";
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
	public String buySong(String email, String songOne) {
		String[] songArr = songOne.split("#");
		System.out.println(songArr[0]);
		System.out.println(songArr[1]);
		System.out.println(songArr[2]);
		System.out.println(songArr[3]);
		JukeboxDto dto = new JukeboxDto(0,email, songArr[0], songArr[1], songArr[2], songArr[3],"N");
		
		int res = 0;
		res = jukedao.insert(dto);
		if(res > 0) {
			return "redirect:jukebox.do?email="+email;
		}else {
			return "searchMusic";
		}
	}
	
	@RequestMapping("/updateBack.do")
	public String backgroundMusic(String email, String[] chk, String[] unchk) {
		int res = 1;
		if(unchk == null||unchk.length == 0) {
			if(chk != null && chk.length != 0) {
				for(int i = 0; i < chk.length; i++) {
					JukeboxDto dto = new JukeboxDto(Integer.parseInt(chk[i]), email, null, null, null, null, "Y");
					jukedao.updateBack(dto);
					res++;
				}
			}
			return "redirect:jukebox.do?email="+email;
		}else {
			for(int i = 0; i < unchk.length; i++) {
				JukeboxDto dto = new JukeboxDto(Integer.parseInt(unchk[i]), email, null, null, null, null, "N");
				jukedao.updateBack(dto);
				res++;
			}
			if(chk == null || chk.length == 0) {
				System.out.println("alert로 알리기");
				return "redirect:jukebox.do?email="+email;
			}else {
				for(int i = 0; i < chk.length; i++) {
					JukeboxDto dto = new JukeboxDto(Integer.parseInt(chk[i]), email, null, null, null, null, "Y");
					jukedao.updateBack(dto);
					res++;
				}
				if(res == (chk.length+unchk.length)) {
					System.out.println("배경음악 저장 성공");
					return "redirect:jukebox.do?email="+email;
				}else {
					System.out.println("배경음악 저장 실패");
					return "redirect:jukebox.do?email="+email;
				}
			}
		}
	}
}
