package com.saisiot.userinfo;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import java.awt.print.PrinterException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.saisiot.jukebox.dao.JukeboxDao;
import com.saisiot.jukebox.dto.JukeboxDto;
import com.saisiot.userinfo.biz.UserinfoBiz;
import com.saisiot.userinfo.dao.UserinfoDao;
import com.saisiot.userinfo.dto.UserinfoDto;
import com.saisiot.userinfo.recapthca.*;

@Component
@Controller
public class HomeController {

	@Autowired
	private UserinfoBiz biz;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private JukeboxDao jukedao;
	
	@RequestMapping(value = "/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model, HttpSession session) {

		model.addAttribute("list", biz.selectList());
		session.getAttribute("dto");

		return "list";
	}

	@RequestMapping("/insertform.do")
	public String insertForm() {

		return "insert";
	}

	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	public String insert(@ModelAttribute UserinfoDto dto) {

		int res = biz.insert(dto);

		if (res > 0) {
			return "redirect:list.do";
		} else {
			return "redirect:insertform.do";
		}

	}

	@RequestMapping(value = "/select.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String select(Model model, String email) {

		model.addAttribute("dto", biz.selectOne(email));

		return "select";
	}
	@RequestMapping(value="/updateform.do")
	public String updateform(Model model, String email) {
		
		model.addAttribute("dto",biz.selectOne(email));	
		
		return "updateform";
	}
	
	@RequestMapping(value="/update.do", method = RequestMethod.POST)
	public String update(@ModelAttribute UserinfoDto dto) {
		
		int res = biz.update(dto);
		
		if(res > 0) {
			return "redirect:list.do";
		} else {
			return "redirect:updateform.do";
		}
		
	}
	
	
	@RequestMapping("/delete.do")
	public String delete(String email) {
		
		int res = biz.delete(email);
		
		if(res>0) {
			return "redirect:list.do";
		}else {
			return "redirect:list.do";
		}

	}
	
	@RequestMapping("/selectOne.do")
	public String selectOne(Model model, String email) {
		
		UserinfoDto dto = biz.selectOne(email);
		
		model.addAttribute("dto", dto);
		
		return "selectOne";
		
	}
	
	@RequestMapping("/login.do")
	public String loginForm() {
		return "login";
	}
	
	
	@RequestMapping(value= "/logingo.do", method = {RequestMethod.POST})
	public String login(String email, @RequestParam("pw") String password, HttpSession session) {
		
		//lee: set session Attribute "whos"- which identifies wheather it's myhome or other's home
		session.setAttribute("whos", "mine");
		String returnURL = "";
		
		System.out.println("+++++++++++++++++++");
		System.out.println(email);
		System.out.println(password);
		
		UserinfoDto dto = biz.login(email, password);
		
		if(session.getAttribute("login")!=null) {
			session.removeAttribute("login");
		}
		
		try {
			if(dto.getEmail().equals(email) && dto.getPassword().equals(password)) {
				System.out.println("------------로그인 성공-------------");	
				
				
					
				int res = biz.lastloginupdate(dto);
					
				System.out.println(res);
				if(res>0) {
					System.out.println("마지막 로그인 시간 변경");
					// 관리자 : 0 , 일반회원 : 1, 휴면계정 : 2, 탈퇴회원 : 3, 이용정지: 4
					System.out.println("휴면계정 상태 (0 : 관리자 , 1 : 일반회원 , 2 : 휴면계정, 3 : 탈퇴회원, 4 : 이용정지) : " + dto.getUsercondition());
					if(dto.getUsercondition()==0) {
						session.setAttribute("login", dto);
						System.out.println("휴면계정이 아닙니다.");
						returnURL = "redirect:homepage.do";
					}else if(dto.getUsercondition()==1) {
						session.setAttribute("login", dto);
						System.out.println("휴면계정이 아닙니다.");
						returnURL = "redirect:homepage.do";
					}else if(dto.getUsercondition()==2) {
						System.out.println("휴면계정입니다.");
						session.setAttribute("login", dto);
						returnURL = "condition";
					}else if(dto.getUsercondition()==3) {
						System.out.println("탈퇴회원 입니다.");
						returnURL = "login";
					}else if(dto.getUsercondition()==4) {
						System.out.println("이용정지된 회원입니다.");
					}
						
					
				}else {
					System.out.println("마지막 로그인 변경 실패");
					returnURL = "login";
				}
				
			}else{
				System.out.println("----------로그인 실패1-----------");
				returnURL = "login";
			}
		}catch(Exception e) {
			System.out.println("----------로그인 실패2-----------");
			returnURL = "login";
		}
			return returnURL;
	}
	
	

	@RequestMapping(value = "/homepage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String homepage(Model model, HttpSession session) {
		
		//lee's editing. show different friendlist depend on variable:'whos'
		String whos = (String)session.getAttribute("whos");
		UserinfoDto dto;
		if(whos.equals("mine")) {
			dto = (UserinfoDto)session.getAttribute("login");
		}else {
			dto = (UserinfoDto)session.getAttribute("others");
		}
		UserinfoDto Udto = (UserinfoDto)session.getAttribute("login");
		
		Map<String, Object> visit_email = new HashMap<String, Object>();
		visit_email.put("email", Udto.getEmail());
		
		
        //오늘 방문자 수
        int todayCount = biz.visit_today(visit_email);
		
        //전체 방문자수
        int totalCount = biz.visit_total(visit_email);
        
        //일주일 방문자 수 통계
        List<Object> week_visit_date = biz.visit_weekdata(visit_email);
        
        System.out.println(todayCount + "d" + totalCount + "s" + week_visit_date + "!!!!!!!!!!!!!!!!!!");
        
        model.addAttribute("todayCount", todayCount);
        model.addAttribute("totalCount",totalCount);
        model.addAttribute("week_visit_date", week_visit_date);
		
		String email  = dto.getEmail();
		List<UserinfoDto> friendList = biz.selectFriendList(email);
		
		session.setAttribute("friendList", friendList);
		
		return "homepage";

		//------------메인홈피에 배경음악 붙이기
		UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
		String email = dto.getEmail();
		List<JukeboxDto> jukelist = new ArrayList<JukeboxDto>();
		jukelist = jukedao.backselect(email, "Y");

		if(jukelist==null) {
			return "homepage";
		}else {
			session.setAttribute("background",jukelist);
			return "homepage";
		}
	}
	
	
	
	@RequestMapping("/logout.do")
	public String logout(String email, String password, HttpSession session) {
		

			session.invalidate();
			//session.removeAttribute("login");
			return "login";
	}
		

	
	@RequestMapping(value = "/userinsert.do", method = {RequestMethod.POST})
	public String insertuser(@ModelAttribute UserinfoDto dto){
		
		System.out.println(dto.getBirthdate());
		System.out.println(dto);
		try {
			int res = biz.insert(dto);
			System.out.println(res);
			if(res>0) {
				System.out.println("회원가입 성공");
				return "redirect:login.do";
			}else {
				System.out.println("회원가입 실패");
				return "redirect:login.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 실패");		
			return "redirect:login.do";
		}
		
		
			
	}
	
	@RequestMapping(value = "/kakaologinajax.do", method = {RequestMethod.POST})
	@ResponseBody
	public String kakaologin(String email, String password, String name, HttpSession session) {
		
		String returnURL = "";
		
		//lee: set session Attribute "whos"- which identifies wheather it's myhome or other's home
		session.setAttribute("whos", "mine");
		try {
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			
			
			if(session.getAttribute("login")!=null) {
				session.removeAttribute("login");
			}
				
		
			try {
				
				UserinfoDto dto = new UserinfoDto(email,password,null,null,null,name,null,null,null,0,1);
				int res = biz.kakaoinsert(dto);
				if(res>0) {
					System.out.println("카카오 회원가입 성공");
			
				}else {
					System.out.println("카카오 회원가입 실패");
				}
				UserinfoDto kakao = biz.kakaologin(email, password, name);
				System.out.println("-------카카오 로그인 성공1--------");
				int res2 = biz.lastloginupdate(kakao);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", kakao);
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}

				
			} catch (Exception e) {
				e.printStackTrace();
				UserinfoDto kakao = biz.kakaologin(email, password, name);
				System.out.println("--------카카오 로그인 성공1-1----------");
				int res2 = biz.lastloginupdate(kakao);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", kakao);
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}
			}	

		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			UserinfoDto kakao = biz.kakaologin(email, password, name);
			System.out.println("-------카카오 로그인 성공2-------");
			int res2 = biz.lastloginupdate(kakao);
			
			System.out.println(res2);
			if(res2>0) {
				System.out.println("-------마지막 로그인 시간 변경--------");
				session.setAttribute("login", kakao);
				returnURL = "redirect:homepage.do";
			}else {
				System.out.println("-------마지막 로그인 변경 실패--------");
				returnURL = "login";
			}
		}	

		return returnURL;
	}
	
	
	@RequestMapping(value = "/naverloginajax.do", method = {RequestMethod.POST})
	@ResponseBody
	public String naverlogin(String email, String password, String name, HttpSession session) {
		
		//lee: set session Attribute "whos"- which identifies wheather it's myhome or other's home
		session.setAttribute("whos", "mine");
		String returnURL = "";
		
		try {
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			
			if(session.getAttribute("login")!=null) {
				session.removeAttribute("login");
			}
		
			try {
				
				UserinfoDto dto = new UserinfoDto(email,password,null,null,null,name,null,null,null,0,1);
				int res = biz.kakaoinsert(dto);
				if(res>0) {
					System.out.println("네이버 회원가입 성공");
			
				}else {
					System.out.println("네이버 회원가입 실패");
				}
				UserinfoDto naver = biz.kakaologin(email, password, name);
				System.out.println("-------네이버 로그인 성공1--------");
				int res2 = biz.lastloginupdate(naver);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", naver);
					System.out.println(naver + "왜 안돼는거야");
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}

				
			} catch (Exception e) {
				e.printStackTrace();
				UserinfoDto naver = biz.kakaologin(email, password, name);
				System.out.println("--------네이버 로그인 성공1-1----------");
				int res2 = biz.lastloginupdate(naver);
				
				System.out.println(res2);
				if(res2>0) {
					System.out.println("-------마지막 로그인 시간 변경--------");
					session.setAttribute("login", naver);
					returnURL = "redirect:homepage.do";
				}else {
					System.out.println("-------마지막 로그인 변경 실패--------");
					returnURL = "login";
				}
			}	

		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(email);
			System.out.println(password);
			System.out.println(name);
			UserinfoDto naver = biz.kakaologin(email, password, name);
			System.out.println("-------네이버 로그인 성공2-------");
			int res2 = biz.lastloginupdate(naver);
			
			System.out.println(res2);
			if(res2>0) {
				System.out.println("-------마지막 로그아웃 시간 변경--------");
				session.setAttribute("login", naver);
				returnURL = "redirect:homepage.do";
			}else {
				System.out.println("-------마지막 로그아웃 변경 실패--------");
				returnURL = "login";
			}
		}	

		return returnURL;
	}
	
	
	@RequestMapping("/mailgo.do")
	public String mailgo() {
		
		return "mailsend";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailsend.do" , method = {RequestMethod.POST})
	public String mailSending(HttpServletRequest request, Model model, String email, String randomcode ) {
		
			String setfrom = "mamstouch0207@gmail.com";         
		    String tomail  = email;     // 받는 사람 이메일
		    String title   = "사이시옷 인증메일 입니다.";      // 제목
		    String content = randomcode;    // 내용
		    
		    System.out.println("메인인증 코드 컨트롤러 : "+ tomail);
		    System.out.println("메일인증 번호 : " + content);
		    
		    
		    try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
		      messageHelper.setTo(tomail);     // 받는사람 이메일
		      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
		      messageHelper.setText(content);  // 메일 내용
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      System.out.println(e);
		    }
		    
		    return content;
		  }

	
	@RequestMapping(value = "/callback.do")
	public String navLogin(HttpServletRequest request) throws Exception {  
		return "callback";
	}
	
	@ResponseBody
	@RequestMapping(value = "VerifyRecaptcha.do", method = RequestMethod.POST)
	public int VerifyRecaptcha(HttpServletRequest request) {
		VerifyRecaptcha.setSecretKey("6LfiDJcUAAAAACHgKUqYeKcg8Otw7qgkc-JVSFPT");
	    String gRecaptchaResponse = request.getParameter("recaptcha");
        System.out.println("리캡쳐!!!!!!" + gRecaptchaResponse);
	        //0 = 성공, 1 = 실패, -1 = 오류
	        try {
	            if(VerifyRecaptcha.verify(gRecaptchaResponse))
	                return 0;
	            else return 1;
	        } catch (IOException e) {
	            e.printStackTrace();
	            return -1;
	        }
	 }

	@ResponseBody
	@RequestMapping(value = "/emailcheck.do", method = RequestMethod.POST)
	public String emailCheck(String email, Model model) {
		
		String returnURL = "";
		
		System.out.println("----------------------");
		System.out.println(email);
		
		try {
			UserinfoDto dto = biz.emailcheck(email);
			
			if(dto.getEmail().equals(email)) {
				System.out.println("중복된 이메일입니다.");
				returnURL = "0";
			}else if(!dto.getEmail().equals(email)) {
				System.out.println("사용가능한 이메일입니다-1.");
				returnURL = "1";
			}
		} catch (Exception e) {
			System.out.println("사용가능한 이메일입니다-2.");
			returnURL = "1";
		}
		
		System.out.println(returnURL);
		return returnURL;
	}
	
	@RequestMapping("/jusoPopup.do")
	public String jusoPopup() {
		
		
		return "jusoPopup";
	}
	
	@RequestMapping("/emailpwFind.do")
	public String idpwFind() {
		
		return "emailpwFind";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/emailpwFindgo.do", method = RequestMethod.POST)
	public String idpwFindgo(String mail) throws ParseException {
		
		String returnURL = "";
		System.out.println(mail);
			
		
		try {
			
			UserinfoDto dto = biz.emailpwfind(mail);
			System.out.println("------비밀번호 초기화 대상 : " + dto.getEmail() + "비밀번호 : " + dto.getPassword() +"---------------");
			if(!dto.getPassword().equals("kakaouser") && !dto.getPassword().equals("naveruser")) {
			
			
			if(dto.getEmail().equals(mail)) {
				
				int res = biz.passupdate(dto);
				
				if(res>0) {
				
				String setfrom = "mamstouch0207@gmail.com";         
			    String tomail  = mail;     // 받는 사람 이메일
			    String title   = "안녕하세요?^^ 사이시옷입니다..";      // 제목
			    String content = "고객님의 EMAIL : "+ dto.getEmail() +"의 비밀번호가 초기화 되었습니다 : 123456789";    // 내용
			    
			    System.out.println("비밀번호 초기화 코드 컨트롤러 : "+ tomail);
			    System.out.println("비밀번호 초기화 : " + content);
			    
			    
			    try {
			      MimeMessage message = mailSender.createMimeMessage();
			      MimeMessageHelper messageHelper 
			                        = new MimeMessageHelper(message, true, "UTF-8");
			 
			      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
			      messageHelper.setTo(tomail);     // 받는사람 이메일
			      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			      messageHelper.setText(content);  // 메일 내용
			     
			      mailSender.send(message);
			    } catch(Exception e){
			      System.out.println(e);
			    }
			    
			    return content;
				
				}else {
					
					returnURL = "0";
				}
			    
			    
			}else {
				
				returnURL = "1";
			}	
			
			}else if(dto.getPassword().equals("kakaouser") || dto.getPassword().equals("naveruser")) {
				
				returnURL = "3";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			returnURL = "1";
		}
		
		
		return returnURL;
	}
	
	@Scheduled(cron = "* * 1 * * *")
	public void longuser() {
		System.out.println("배치프로그램 작동");
		try {
			List<UserinfoDto> dto = biz.longuser();
			
			for(UserinfoDto dtos : dto ) {
				System.out.println(dtos.getEmail());
				System.out.println("휴면 계정 대상자 : " + dtos.getEmail());
				UserinfoDto dto2 = new UserinfoDto(dtos.getEmail(),dtos.getPassword(),dtos.getGender(),dtos.getJoindate(),dtos.getBirthdate(),dtos.getUsername(),dtos.getVisitdate(),dtos.getPwdate(),dtos.getAddr(),dtos.getCoinno(),dtos.getUsercondition());
				int res = biz.longupdate(dto2);
				
				if(res>0) {
					System.out.println("휴면계정으로 변경");
				}else {
					System.out.println("휴면계정으로 변경될 대상이 없습니다.");
				}
		
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			//List<UserinfoDto> dto = biz.longuser();
		}	
		
	}
	
	//--------------lee's editing------------------------------------------------------
	
	@RequestMapping(value = "/otherhome.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String otherhome(Model model, HttpSession session, HttpServletRequest request) {
		
		String email = request.getParameter("email");
		session.setAttribute("whos","others");
		session.setAttribute("others", biz.selectOne(email));

		return "redirect:homepage.do";
	}
	
} 

