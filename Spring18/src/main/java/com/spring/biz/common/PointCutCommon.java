package com.spring.biz.common;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;


//포인트컷만 만들어 놓은 클래스
@Aspect
public class PointCutCommon {

	//포인트컷
	@Pointcut("execution(* com.spring.biz..*Impl.*(..))")
	public void allPointCut() {}

	@Pointcut("execution(* com.spring.biz..*Impl.get*(..))")
	public void getPointCut() {}
	
}
