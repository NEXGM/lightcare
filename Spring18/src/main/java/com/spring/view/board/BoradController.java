package com.spring.view.board;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.biz.board.impl.BoardService;
import com.spring.biz.common.BoardDTO;

@Controller
@SessionAttributes("board")
public class BoradController {
	
	@Autowired
	BoardService  boardService;   // 부모인 인터페이스로 주입한다

	// view에서  forEach를 활용해보려고  만들어 놓았다.
	@ModelAttribute("conditionMap")
	public Map<String,String> searchConditionMap(){
		
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("제목","TITLE");
		conditionMap.put("내용","CONTENT");
		
		return conditionMap; 
	}
	
	
	
	
	@RequestMapping("/getBoardList.do" )
	public String getBoardList(BoardDTO  vo,  Model model) throws Exception {
		
		//혹시 null이라면 ...  TITLE을 디폴트로 하자
		if(vo.getSearchCondition() == null)  vo.setSearchCondition("TITLE");
		if(vo.getSearchKeyword()  == null)  vo.setSearchKeyword("");
		
		
		model.addAttribute("boardList", boardService.getBoardList(vo)) ;
		return "board/getBoardList";
	}
	
	
	
	
	
	@RequestMapping("/getBoard.do")
	public String getBoard(BoardDTO vo,  Model model) throws Exception {
		
		// getBoardList에서  vo.seq >> 상세검색  getBoard.do 로 온것이다
		model.addAttribute("board",boardService.getBoard(vo)); 
		return "board/getBoard";
	}
	// 새 글 등록 폼 페이지로 이동하는 GET 메서드 추가!
	// 사용자가 "새글등록" 링크를 클릭하면 이 메서드가 호출되어 insertBoard.jsp를 보여준다.
	@RequestMapping(value = "/insertBoard.do", method = RequestMethod.GET) // GET 방식 지정
	public String insertBoardView() {
		System.out.println("--- insertBoard.jsp 폼 페이지 요청 진입 (GET) ---");
		return "board/insertBoard"; // /WEB-INF/views/board/insertBoard.jsp 를 찾게 됨
	}
	
	@RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
	public String insertBoard(BoardDTO vo) throws Exception {
		System.out.println("--- insertBoard.do 요청 진입 ---");
		System.out.println("BoardDTO vo 객체 내용: " + vo.toString()); // vo 객체의 현재 상태 출력
		System.out.println("제목: " + vo.getTitle());
		System.out.println("작성자: " + vo.getWriter());
		System.out.println("내용: " + vo.getContent());
		boardService.insertBoard(vo);  // 현재는 폼에서 온 파라미터는 vo에 넣지 않았다. 
		return "redirect:getBoardList.do";
	}
	
	
	//update (실습)
	@RequestMapping("/updateBoard.do")
	public String updateBoard(@ModelAttribute("board") BoardDTO vo) throws Exception {
		
		System.out.println("--- updateBoard.do 요청 진입 ---");
		System.out.println("BoardDTO vo 객체 내용 (수정 전송): " + vo.toString());		
		System.out.println(vo.toString());		
		boardService.updateBoard(vo);		
		
		return "redirect:getBoardList.do?seq=" + vo.getSeq();
	}
	
	//delete (실습)
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(BoardDTO vo) throws Exception {
		System.out.println("--- deleteBoard.do 요청 진입 ---");
		System.out.println("삭제할 BoardDTO vo 객체 내용: " + vo.toString());
		
		boardService.deleteBoard(vo);
		System.out.println("--- boardService.deleteBoard(vo) 호출 완료 ---");
		
		// 삭제 후 게시글 목록으로 리다이렉트
		return "redirect:getBoardList.do";
	}
}






