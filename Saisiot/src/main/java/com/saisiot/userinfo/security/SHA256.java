package com.saisiot.userinfo.security;

import java.security.MessageDigest;

public class SHA256 {
	   public static String getSHA256(String input) {
	      StringBuffer result = new StringBuffer();
	      try {
	         MessageDigest md = MessageDigest.getInstance("SHA-256");//사용자 입력한 암호,이메일을 sha-256이용
	         byte[] salt = "Salt in Hellow".getBytes();//단순하게 sha 이용하면 복호화 가능함... 따라서 쏠트를 더해서 넣어줌
	         md.reset();
	         md.update(salt);
	         byte[] chars = md.digest(input.getBytes("UTF-8"));
	         for(int i = 0; i < chars.length; i++) {
	            String hex = Integer.toHexString(0xff & chars[i]);
	            if(hex.length() == 1) result.append('0');//16진수 값
	            result.append(hex);
	         }
	      } catch (Exception e) {
	         System.out.println("sha256 에러");
	         e.printStackTrace();
	      }
	      System.out.println("암호화 : " + result.toString());
	      return result.toString();// 결과 반환
	   }
	   
}