
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

	@RequestMapping(value = "/diary.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String diary(Model model) {

		model.addAttribute("list", Dbiz.selectList());

		return "diary";
	}

	@RequestMapping(value = "/insertForm_diary.do")
	public String insertForm_Diary() {

		return "insert_diary";
	}
	
	@RequestMapping(value="/video.do")
	public String video() {
		
		return "videotest";
	}
	

	@RequestMapping(value = "/diary_insert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String insert_Diary(@ModelAttribute DiaryDto dto, HttpServletRequest request, Model model,
			UploadFile uploadFile, BindingResult result) throws IOException {

		String picurl = "";
		
		String content = dto.getContent();
		
		int a = content.indexOf("upload");
		
		// 이미지 파일이 업로드 되었으면
		if(a != -1) {
		
		String img_src = content.substring(a);

		int c = img_src.indexOf(34);

		picurl = "upload\\"+img_src.substring(7, c);
		
		dto.setPicurl(picurl);
		
		if (uploadFile.getFile().isEmpty() == true) {

			int res = Dbiz.insert(dto);

			if (res > 0) {

				return "diary";

			} else {

				return "redirect:insert_diary";

			}
		} else {
			
			// 유효성검사
			fileValidator.validate(uploadFile, result);

			// 오류정보가 존재시 uploadForm으로 간다.
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
				System.out.println("업로드 될 실제 경로 : " + path);

				/*
				 * 경로 절대경로 : C:\workspace\....\storage 상대경로 : ../(상위 폴더) ./(현재 폴더)
				 * /(root->localhost:8787/ : 이뒤에 붙는다.)
				 */

				// storage가 존재하지 않으면 만든다.
				File storage = new File(path);
				if (!storage.exists()) {
					storage.mkdirs();
				}

				// newfile이 존재하지 않으면 newfile을 만든다.
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

			int res = Dbiz.insert(dto);

			if (res > 0) {

				return "diary";

			} else {

				return "redirect:insert_diary";

			}
		}
		
		} else {
			
			int res = Dbiz.insert(dto);

			if (res > 0) {

				return "diary";

			} else {

				return "redirect:insert_diary";

			}
		}

	}
	
	@RequestMapping("/download.do")
	@ResponseBody
	public byte[] fileDown(HttpServletRequest request,HttpServletResponse response, String filename) throws IOException {
		
		String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/upload");
		File file = new File(path+"/"+filename);
		
		byte[] bytes = FileCopyUtils.copyToByteArray(file); // 가져온 file값을 copyToByteArray를 이용하여 배열로 모든 data를가져옴
		String fn = new String(file.getName().getBytes(),"8859_1");
		
		response.setHeader("Content-Disposition", "attachment;filename=\""+fn+"\"");
		response.setContentLength(bytes.length);
		response.setContentType("image/jpeg");
		// servers - tomcat - web.xml에서 mime-mapping을 보면 jpg,doc,ppt 등등 다운받을수있는 파일의 타입을 잡아줄수있다. 
		// 기본적인 값 외에 내가 필요한게 있으면 따로 추가 가능하다.
		
		return bytes;
	}
	

	@RequestMapping(value="/insertForm_folder.do")
	public String insertForm_Folder(HttpSession session) {
		
		UserinfoDto userinfo = (UserinfoDto)session.getAttribute("login");
		
		return "insert_folder";
	}

	@RequestMapping(value = "/diaryDetail.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String diaryDetail(@RequestParam int diaryno, Model model) {

		model.addAttribute("dto", Dbiz.selectOne(diaryno));

		return "diary_detail";
	}

	// 게시글 목록
	@RequestMapping("/listall.do")
	// @RequestParam(defaultValue="") ==> 기본값 할당
	public ModelAndView list(@RequestParam(defaultValue = "title") String searchOption,
			@RequestParam(defaultValue = "") String keyword, @RequestParam(defaultValue = "1") int curPage)
			throws Exception {
		// 총 게시글 수 계산
		int count = Dbiz.countArticle(searchOption, keyword);
		// 페이지 나누기 관련 처리
		Paging paging = new Paging(count, curPage);
		int start = paging.getPageBegin();
		int end = paging.getPageEnd();
		List<DiaryDto> list = Dbiz.diarylist(start, end, searchOption, keyword);
		/* List<PagingDto> answerlist= pagingBiz.Answerlist(pagingDto.getGroupno()); */
		/* System.out.println("answerlist="+answerlist); */
		// 데이터를 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		/* map.put("answerlist=", answerlist);//답글list */
		map.put("list", list); // list
		map.put("count", count); // 레코드의 갯수
		map.put("searchOption", searchOption); // 검색옵션
		map.put("keyword", keyword); // 검색키워드
		map.put("paging", paging);
		// ModelAndView - 모델과 뷰
		ModelAndView mav = new ModelAndView();

		mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
		mav.setViewName("diary_list"); // 뷰를 list.jsp로 설정
		return mav; // list.jsp로 List가 전달된다.
	}

}