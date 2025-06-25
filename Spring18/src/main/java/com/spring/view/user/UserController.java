package com.spring.view.user; // 이 패키지 명과 실제 파일 위치가 일치해야 해!

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.biz.common.UserDTO;
import com.spring.biz.user.impl.UserService; // 올바른 UserService 인터페이스 임포트

@Controller
@SessionAttributes("user") // 세션에 "user" 객체를 저장하여 다른 요청에서도 사용 가능하게 함
public class UserController { 
	
	@Autowired
	UserService userService; // UserService 주입 (이제 BoardService가 아님!)

	// --- 회원가입 폼으로 이동 (GET 요청) ---
	@RequestMapping(value = "/insertUser.do", method = RequestMethod.GET)
	public String insertUserView() {
		System.out.println("--- insertUser.jsp (회원가입 폼) 요청 진입 (GET) ---");
		return "user/insertUser"; // /WEB-INF/views/user/insertUser.jsp 로 포워딩
	}

	// --- 회원가입 처리 (POST 요청) ---
	@RequestMapping(value = "/insertUser.do", method = RequestMethod.POST)
	public String insertUser(UserDTO vo) {
		System.out.println("--- insertUser.do (회원가입 처리) 요청 진입 (POST) ---");
		System.out.println("회원가입 UserDTO vo: " + vo.toString());
		try {
		    userService.insertUser(vo); // 서비스의 insertUser 메서드 호출
		    System.out.println("--- 회원가입 완료 ---");
		    return "redirect:/login.do"; // 회원가입 성공 후 로그인 페이지로 리다이렉트
		} catch (Exception e) {
		    System.err.println("회원가입 중 오류 발생: " + e.getMessage());
		    return "user/insertUser"; // 예시: 오류 발생 시 다시 폼으로
		}
	}
	
	// --- 회원 정보 상세 조회 (관리자용 또는 본인 정보 조회) ---
    // @RequestParam "id"를 통해 조회할 회원의 ID를 받는다.
	@RequestMapping("/getUser.do")
	public String getUser(@RequestParam String id, Model model) {
	    System.out.println("--- getUser.do (회원 상세 조회) 요청 진입 ---");
	    UserDTO vo = new UserDTO();
	    vo.setId(id); // 조회할 ID 설정
	    UserDTO user = null;
	    try {
	        user = userService.getUser(vo); // ID만으로 사용자 정보 조회 (패스워드 필요 없음)
	    } catch (Exception e) {
	        System.err.println("회원 상세 조회 중 오류 발생: " + e.getMessage());
	    }
	    model.addAttribute("user", user); // 모델에 사용자 정보 추가
	    return "user/getUser"; // /WEB-INF/views/user/getUser.jsp 로 포워딩
	}

	// --- 회원 목록 조회 (관리자용) ---
	// 검색 기능을 위해 UserDTO를 파라미터로 받는다.
	@RequestMapping("/getUserList.do")
	public String getUserList(UserDTO vo, Model model) {
		System.out.println("--- getUserList.do (회원 목록 조회) 요청 진입 ---");
		List<UserDTO> userList = null;
		try {
		    userList = userService.getUserList(vo); // UserService의 getUserList 호출
		} catch (Exception e) {
		    System.err.println("회원 목록 조회 중 오류 발생: " + e.getMessage());
		}
		model.addAttribute("userList", userList);
		return "user/getUserList"; // /WEB-INF/views/user/getUserList.jsp 로 포워딩
	}
	
	// --- 회원 정보 수정 (GET/POST) 및 삭제 기능은 이번 요청에서 제외되었음 (주석 처리) ---
	// 필요하다면 이전에 제공했던 코드 블록을 참고하여 다시 추가할 수 있습니다.
}
