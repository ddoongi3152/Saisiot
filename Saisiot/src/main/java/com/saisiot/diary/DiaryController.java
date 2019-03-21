package com.saisiot.diary;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.saisiot.diary.dto.DiaryDto;
import com.saisiot.common.UploadFile;
import com.saisiot.common.FileValidator;
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

   
   @RequestMapping(value = "/diary_insert.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String insert_Diary(@ModelAttribute DiaryDto dto, HttpServletRequest request, Model model, UploadFile uploadFile, BindingResult result)
         throws IOException {
      

      // ��ȿ�� �˻�(÷�������� ������ �ؿ� ��ɵ鵵 ����ȵ�.)
      fileValidator.validate(uploadFile, result);

      // ���������� ����� �ٽ� form����
      if (result.hasErrors()) {
         return "insert_diary";
      }

      MultipartFile file = uploadFile.getFile();
      String storefilename = file.getName();
      String filename = file.getOriginalFilename();
      System.out.println("���� �� ���� �� : " + storefilename);
      System.out.println("�� �Ӿ� "+filename);

      UploadFile fileobj = new UploadFile();
      fileobj.setFilename(filename);

      InputStream inputStream = null;
      OutputStream outputStream = null;

      try {
         inputStream = file.getInputStream();
         String path = WebUtils.getRealPath(request.getSession().getServletContext(), "se/upload/");

         System.out.println("���ε� �� ���� ��� : " + path);

         /*
          * ��� ������ : C:\workspace\....\storage ����� : ../(���� ����) ./(���� ����)
          * /(root->localhost:8787/ : �̵ڿ� �ٴ´�.)
         */ 

         // storage�� �������� ������ �����.
         File storage = new File(path);
         if (!storage.exists()) {
            storage.mkdirs();
         }

         // newfile�� �������� ������ newfile�� �����.
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
      
      String img_src = dto.getContent();
      System.out.println("img : " + img_src);
      
      dto.setFileurl(filename);
      dto.setPicurl(img_src);
      
      System.out.println("���� �Ϸοо�뷯��������"+dto.getContent());
      System.out.println(dto.getMaplati());
      System.out.println(dto.getMaplong());
      System.out.println(dto.getTitle());
      System.out.println(dto.getFileurl());
      System.out.println(dto.getPicurl());
      
      int res = Dbiz.insert(dto);
      
      if(res >0) {
         
         return "diary";
         
      } else {
            
         return "redirect:insert_diary"; 
         
      }

   }
   
   @RequestMapping(value="/diaryDetail.do", method= {RequestMethod.POST,RequestMethod.GET} )
   public String diaryDetail(@RequestParam int diaryno ,Model model ) {
      
      model.addAttribute("dto", Dbiz.selectOne(diaryno));
      
      return "diary_detail";
   }
}