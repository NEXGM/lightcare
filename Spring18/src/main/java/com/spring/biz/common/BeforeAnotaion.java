package com.spring.biz.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Component("beforeJoin")
@Aspect   // Pointcut + Advice 결합설정이 되어 있어야 한다. >> 스프링이 Aspect로 인식한다
public class BeforeAnotaion {
	
	//포인트컷
	@Pointcut("execution(* com.spring.biz..*Impl.*(..))")
	public void allPointCut() {}

	@Pointcut("execution(* com.spring.biz..*Impl.get*(..))")
	public void getPointCut() {}
	
	
	
	//어드바이스
	@Before("allPointCut()")
	public void beforeLog(JoinPoint jp) {
		String method = jp.getSignature().getName();
		Object[] args = jp.getArgs();
		
		//요청한 본 객체의 메서드와 매개변수 를 출력해보자 >>  getBoardList()에서 vo를 삭제해서 오류가 발생한것이다
		//System.out.println("[사후처리] "+method+"()메소드 args정보>> "+args[0].toString());
	}
	
	
}
