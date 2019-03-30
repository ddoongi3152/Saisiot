package com.saisiot.diary;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.saisiot.diary.dto.DiaryDto;
import com.saisiot.diary.dto.DiaryRootDto;
import com.saisiot.userinfo.dto.UserinfoDto;
import com.saisiot.common.UploadFile;
import com.saisiot.common.Editor;
import com.saisiot.common.FileValidator;
import com.saisiot.common.Paging;
import com.saisiot.diary.biz.DiaryBiz;

@Controller
public class DiaryController {

	@Autowired
	private DiaryBiz Dbiz;

	@Autowired
	private FileValidator fileValidator;

	@RequestMapping(value = "/insertForm_diary.do")
	public String insertForm_Diary() {

		return "diary_insert";
	}
	
	@RequestMapping(value="/insertForm_folder.do")
	public String insertForm_Folder() {

		return "folder_insert";
	}
	
	@RequestMapping("/folder_insert.do")
	public String insert_Folder(@ModelAttribute DiaryRootDto dto) {

		Dbiz.folder_insert(dto);
		
		return "redirect:diary.do";
	}
	
	@RequestMapping("/selectForm_map.do")
	public String selectForm_Map() {
		
		return "map";
	}
	
	@RequestMapping("/selectForm_video.do")
	public String selectForm_Video() {
		
		return "video";
	}
	

	@RequestMapping(value = "/diary_insert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String insert_Diary(@ModelAttribute DiaryDto dto, HttpServletRequest request, Model model,
			UploadFile uploadFile, BindingResult result) throws IOException {
		
		String picurl = "";
		
		String content = dto.getContent();
		
		int a = content.indexOf("upload");
		
		// ?��미�? ?��?��?�� ?��로드 ?��?��?���?
		if(a != -1) {
		
		String img_src = content.substring(a);

		int c = img_src.indexOf(34);

		picurl = "upload\\"+img_src.substring(7, c);
		
		dto.setPicurl(picurl);
		
		if (uploadFile.getFile().isEmpty() == true) {

			Dbiz.insert(dto);

			return "diary";

		} else {
			
			// ?��?��?���??��
			fileValidator.validate(uploadFile, result);

			// ?��류정보�? 존재?�� uploadForm?���? 간다.
			if (result.hasErrors()) {
				return "uploadForm";
			}

			MultipartFile file = uploadFile.getFile();
			String filename = file.getOriginalFilename();

			UploadFile fileobj = new UploadFile();
			fileobj.setFilename(filename);
			fileobj.setDesc(uploadFile.getDesc());

			InputStream inputStream = null;
			OutputStream outputStream = null;

			try {
				inputStream = file.getInputStream();
				String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/upload");
				System.out.println("?��로드 ?�� ?��?�� 경로 : " + path);

				/*
				 * 경로 ?��??경로 : C:\workspace\....\storage ?��??경로 : ../(?��?�� ?��?��) ./(?��?�� ?��?��)
				 * /(root->localhost:8787/ : ?��?��?�� 붙는?��.)
				 */

				// storage�? 존재?���? ?��?���? 만든?��.
				File storage = new File(path);
				if (!storage.exists()) {
					storage.mkdirs();
				}

				// newfile?�� 존재?���? ?��?���? newfile?�� 만든?��.
				File newfile = new File(path + "/" + filename);
				if (!newfile.exists()) {
					newfile.createNewFile();
				}

				outputStream = new FileOutputStream(newfile);

				int read = 0;
				byte[] b = new byte[(int) file.getSize()];

				while ((read = inputStream.read(b)) != -1) {
					outputStream.write(b, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					inputStream.close();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			dto.setFileurl(filename);

			Dbiz.insert(dto);

				return "redirect:diary.do";

		}
		
		} else {
			
			Dbiz.insert(dto);

				return "redirect:diary.do";

		}

	}
	
	@RequestMapping("/download.do")
	@ResponseBody
	public byte[] fileDown(HttpServletRequest request,HttpServletResponse response, String filename) throws IOException {
		
		String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/upload");
		File file = new File(path+"/"+filename);
		
		byte[] bytes = FileCopyUtils.copyToByteArray(file); // �??��?�� file값을 copyToByteArray�? ?��?��?��?�� 배열�? 모든 data를�??��?��
		String fn = new String(file.getName().getBytes(),"8859_1");
		
		response.setHeader("Content-Disposition", "attachment;filename=\""+fn+"\"");
		response.setContentLength(bytes.length);
		response.setContentType("image/jpeg");
		// servers - tomcat - web.xml?��?�� mime-mapping?�� 보면 jpg,doc,ppt ?��?�� ?��?��받을?��?��?�� ?��?��?�� ???��?�� ?��?��줄수?��?��. 
		// 기본?��?�� �? ?��?�� ?���? ?��?��?���? ?��?���? ?���? 추�? �??��?��?��.
		
		return bytes;
	}


	//게시판 목록
	@RequestMapping(value = "/diary.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public ModelAndView diary(@RequestParam(defaultValue = "title") String searchOption,
	         @RequestParam(defaultValue = "") String keyword, @RequestParam(defaultValue = "1") int curPage, String email)
	         throws Exception {
	      // 총 게시글 수 계산
	      int count = Dbiz.countArticle(searchOption, keyword);
	      // 페이지 나누기 관련 처리
	      Paging paging = new Paging(count, curPage);
	      int start = paging.getPageBegin();
	      int end = paging.getPageEnd();
	      List<DiaryDto> list = Dbiz.diarylist(start, end, searchOption, keyword);
	      List<DiaryDto> commentList= Dbiz.commentList();
	      List<DiaryRootDto> folderList = Dbiz.folderList(email);
	      /* System.out.println("commentList="+commentList); */
	      // 데이터를 맵에 저장
	      Map<String, Object> map = new HashMap<String, Object>();
	      map.put("commentList", commentList);//답글list 
	      map.put("folderList",folderList);//폴더list
	      map.put("list", list); // list
	      map.put("count", count); // 레코드의 갯수
	      map.put("searchOption", searchOption); // 검색옵션
	      map.put("keyword", keyword); // 검색키워드
	      map.put("paging", paging);
	      // ModelAndView - 모델과 뷰
	      ModelAndView mav = new ModelAndView();

	      mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
	      mav.setViewName("diary"); // 뷰를 list.jsp로 설정
	      return mav; // list.jsp로 List가 전달된다.
	   }
	
	//comment_insert
	@RequestMapping("/comment_insert")
	public String insert(@ModelAttribute DiaryDto dto,@RequestParam int diaryno,HttpSession session){

		//세션에 저장된 회원아이디를 댓글작성자에 세팅
		String whos = (String)session.getAttribute("whos");
		UserinfoDto userdto;
		if(whos.equals("mine")) {
			userdto = (UserinfoDto)session.getAttribute("login");
			dto.setEmail(userdto.getEmail());
			// 댓글 입력 메서드 호출
			Dbiz.comment_insert_proc(dto,diaryno);
			return "redirect:diary.do";
		}else {
			userdto = (UserinfoDto)session.getAttribute("others");
			dto.setEmail(userdto.getEmail());
			// 댓글 입력 메서드 호출
			Dbiz.comment_insert_proc(dto,diaryno);
			return "redirect:diary.do";
		}
		
	}
	
	//comment_delete
	@RequestMapping("/comment_delete")
	public String comment_delete(@ModelAttribute DiaryDto dto) {
		Dbiz.comment_delete(dto);
		
		return "redirect:diary.do";
	}
	
	// gallery popup open
	@RequestMapping("/gallery_popup.do")
	public String gallery_popup(Model model, String email) {
		List<DiaryRootDto> folderList = Dbiz.folderList(email);
		model.addAttribute("folderList", folderList);
		
		return "gallery_popup";
	}
	
	// gallery insert
	@RequestMapping("/canvas_save.do")
	public String gallery_insert(@ModelAttribute DiaryDto dto,String imgUrlHidden, HttpServletRequest request) {
		System.out.println(dto.getEmail());
		System.out.println(dto.getTitle());
		System.out.println(dto.getContent());
		System.out.println(dto.getPicurl());
		
		int res = Dbiz.insert(dto);
		
		if(res > 0) {
			System.out.println("갤러리 이미지 다이어리 저장 성공");
			return "diary";
		}else {
			System.out.println("갤러리 이미지 다이어리 저장 실패");
			return "gallery";
		}
	}
}