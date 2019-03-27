package com.saisiot.scheduler;


import java.util.Date;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
public class Scheduler {
  /*  @Scheduled(fixedRate = 2000) // 수행 시작 기점, 2초 후 실행 
    public void fixedRateTest() {
        System.out.println("fixedRate: 2sec -> " + new Date());
    }
    @Scheduled(fixedDelay = 7000) // 수행 종료 기점, 7초 후 실행 
    public void fixedDelayTest() {
        System.out.println("fixedDelay: 7sec -> " + new Date());
    }*/
	
    @Scheduled(cron = "* * * 1 * *") // 1초마다 수행
    public void cronTest() {
    	//System.out.println("서버접속시간 : " + new Date());
    	
    }
}

