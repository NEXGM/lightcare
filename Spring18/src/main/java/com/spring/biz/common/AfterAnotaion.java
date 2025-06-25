package com.spring.biz.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class AfterAnotaion {

	//어드바이스
	@AfterReturning(pointcut="PointCutCommon.allPointCut()", returning = "returnObj")
	public void afterLog(JoinPoint jp, Object returnObj) {
		System.out.println("[사후처리]  포인트컷을 한군데 모아서 일괄처리로 적용한것입니다.");
		
		//필요한 코드 작성
	}
}
