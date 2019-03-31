package com.saisiot.profile.dto;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class FileValidator implements Validator {

	// validator 사용 가능한지 여부확인
	@Override
	public boolean supports(Class<?> clazz) {
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		UploadFile file=(UploadFile) target;
		
		if(file.getFile().getSize()==0) {
			// error메세지를 해당 path로
			// file(field)에 대한 errorCode를 return 
			// errorCode가 없으면 default message(Please select a file) 전달
			errors.rejectValue("file","errorCode","Please select a file");
			
		}

	}

}
