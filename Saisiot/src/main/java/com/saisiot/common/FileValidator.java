package com.saisiot.common;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.saisiot.common.UploadFile;

@Service
public class FileValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {

		UploadFile file = (UploadFile)target;
		
		if(file.getFile().getSize()==0) {
			errors.rejectValue("file", "errorCode", "Please select a file");
			
		}
	}

}
