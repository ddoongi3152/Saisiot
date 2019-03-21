package com.saisiot.aop;

import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogAop {
	
	public void before(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget()+"");
		
		logger.info("-------<logger start>-------");
		Object[] args = join.getArgs();
		
		if(args != null) {
			logger.info("Method : \t" + join.getSignature().getName());
			
			for(int i = 0; i < args.length; i++) {
				logger.info(i+"번째 : \t" + args[i]);
			}
			
		}
	}
	
	/* join.getTarget() : 대상 객체
	 * .getArgs() : 대상 파라미터
	 * .getSignature : 대상 메소드 정보
	*/
	
	
	public void after(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(""+join.getTarget());
		logger.info("-------<logger end>-------");
	}
	
	public void afterThrowing(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget()+"");
		logger.info("에러 : \t" + join.getArgs());
		logger.info("에러 : \t" + join.toString());
	}

}

/*
 * log4j의 로그레벨
 * -FATAL : 치명적인 에러일 때만 출력
 * -ERROR : 에러일때만 출력
 * -WARN : 경고일때만 출력
 * -INFO : 정보
 * -DEBUG : 상세정보 
 */