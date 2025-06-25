package com.spring.view.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.biz.common.UserDTO;
import com.spring.biz.user.impl.UserService; // UserService 임포트

@Controller
public class LogController {
	
	@Autowired
	UserService userService; // UserService 주입

	// 로그인 폼 페이지 요청 (GET 방식)
	@RequestMapping(value = "/login.do" , method = RequestMethod.GET)
	public String loginView() { // 메서드 이름을 loginView로 변경하여 POST와 구분
		System.out.println("--- 로그인 폼 페이지 요청 진입 (GET) ---");
		return "board/login";  // /WEB-INF/views/board/login.jsp 를 찾게 됨 (login.jsp가 board 폴더에 있다고 가정)
	}
	
	// 로그인 인증 처리 (POST 방식)
	@RequestMapping(value = "/login.do" , method = RequestMethod.POST)
	public String login(UserDTO vo, HttpSession session) { // throws Exception 제거 (아래서 직접 처리)
		
		System.out.println("--- 로그인 인증처리 진입 (POST) ---");
		System.out.println("로그인 시도 UserDTO: " + vo.toString());

		UserDTO user = null;
		try {
		    user = userService.getUser(vo); // 사용자 정보 조회 시도
		} catch (Exception e) {
		    // !!! 여기서 실제 예외 스택 트레이스를 콘솔에 출력 !!!
		    System.err.println("로그인 처리 중 예외 발생: " + e.getMessage());
		    e.printStackTrace(); // 어떤 예외인지 상세히 확인
		    // 예외 발생 시 로그인 실패 처리 또는 에러 페이지로 이동 (지금은 로그인 폼으로 다시)
		    return "board/login"; 
		}

		if(user != null) { // 로그인 성공 시
			System.out.println("로그인 성공: " + user.getName() + " (" + user.getRole() + ")");
			session.setAttribute("user", user); // 세션에 사용자 정보 저장
			
			// 사용자 역할(role)에 따라 다른 페이지로 리다이렉트
			if ("관리자".equals(user.getRole())) {
				System.out.println("관리자 로그인, getUserList.do로 리다이렉트");
				return "redirect:getUserList.do"; // 관리자는 회원 목록 페이지로
			} else { // 일반 사용자 또는 다른 역할
				System.out.println("일반 사용자 로그인, getBoardList.do로 리다이렉트");
				return "redirect:getBoardList.do"; // 일반 사용자는 게시판 목록 페이지로
			}
		} else { // 로그인 실패 시 (user가 null일 경우)
			System.out.println("로그인 실패: ID 또는 비밀번호 불일치");
			return "board/login"; // /WEB-INF/views/board/login.jsp 로 포워딩
		}
	}
	
	// 로그아웃 처리
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		System.out.println("--- 로그아웃 처리 진입 ---");
		session.invalidate(); // 세션 무효화 (로그아웃 처리)
		System.out.println("--- 로그아웃 완료 ---");
		return "redirect:login.do"; // 로그아웃 후 로그인 페이지로 리다이렉트
	}
}
