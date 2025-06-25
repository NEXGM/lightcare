package com.spring.view.common;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice("com.spring.view")
public class CommonExceptionHandler {
	
	@ExceptionHandler(ArithmeticException.class)
	public ModelAndView handlerArithmeticException(Exception e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception",e);
		mav.setViewName("../../common/arithmeticError");
		return mav;
	}
	
	public ModelAndView handleNullPointException(Exception e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception",e);
		mav.setViewName("../../common/nullpointError");
		return mav;
	}
	
	// Exception 오류
	@ExceptionHandler(Exception.class)
	public ModelAndView handleException(Exception e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception",e);
		mav.setViewName("../../common/error");
		return mav;
	}
}
