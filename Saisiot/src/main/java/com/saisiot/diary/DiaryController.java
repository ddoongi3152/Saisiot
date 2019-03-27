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

		return "diary_insert";
	}
	
	@RequestMapping(value="/insertForm_folder.do")
	public String insertForm_Folder() {
		
		return "folder_insert";
	}
	
	@RequestMapping("/folder_insert.do")
	public String insert_Folder() {
		
		return "";
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

			int res = Dbiz.insert(dto);

			if (res > 0) {

				return "diary";

			} else {

				return "redirect:diary_insert";

			}
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

			int res = Dbiz.insert(dto);

			if (res > 0) {

				return "diary";

			} else {

				return "redirect:diary_insert";

			}
		}
		
		} else {
			
			int res = Dbiz.insert(dto);

			if (res > 0) {

				return "diary";

			} else {

				return "redirect:diary_insert";

			}
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

	@RequestMapping(value = "/diaryDetail.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String diaryDetail(@RequestParam int diaryno, Model model) {

		model.addAttribute("dto", Dbiz.selectOne(diaryno));

		return "diary_detail";
	}

	// 게시�? 목록
	@RequestMapping("/listall.do")
	// @RequestParam(defaultValue="") ==> 기본�? ?��?��
	public ModelAndView list(@RequestParam(defaultValue = "title") String searchOption,
			@RequestParam(defaultValue = "") String keyword, @RequestParam(defaultValue = "1") int curPage)
			throws Exception {
		// �? 게시�? ?�� 계산
		int count = Dbiz.countArticle(searchOption, keyword);
		// ?��?���? ?��?���? �??�� 처리
		Paging paging = new Paging(count, curPage);
		int start = paging.getPageBegin();
		int end = paging.getPageEnd();
		List<DiaryDto> list = Dbiz.diarylist(start, end, searchOption, keyword);
		/* List<PagingDto> answerlist= pagingBiz.Answerlist(pagingDto.getGroupno()); */
		/* System.out.println("answerlist="+answerlist); */
		// ?��?��?���? 맵에 ???��
		Map<String, Object> map = new HashMap<String, Object>();
		/* map.put("answerlist=", answerlist);//?���?list */
		map.put("list", list); // list
		map.put("count", count); // ?��코드?�� �??��
		map.put("searchOption", searchOption); // �??��?��?��
		map.put("keyword", keyword); // �??��?��?��?��
		map.put("paging", paging);
		// ModelAndView - 모델�? �?
		ModelAndView mav = new ModelAndView();

		mav.addObject("map", map); // 맵에 ???��?�� ?��?��?���? mav?�� ???��
		mav.setViewName("diary_list"); // 뷰�?? list.jsp�? ?��?��
		return mav; // list.jsp�? List�? ?��?��?��?��.
	}

}