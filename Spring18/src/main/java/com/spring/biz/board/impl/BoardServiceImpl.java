package com.spring.biz.board.impl;

import java.lang.annotation.Target;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.biz.common.BoardDTO;

//@Component("boardService")
@Service("boardService")
@Transactional(rollbackFor = Exception.class)  // ------------  클래스 전체 또는 필요한 메소드에 설정가능
public class BoardServiceImpl implements BoardService {

	@Autowired  // 의존성주입 (필드) - 마침 하나밖에 없다. 그래서 @Qulifier 사용안함. , 기본생성 
	private BoardDAO_mybatis boardDAO;

	@Override
	//@Transactional(rollbackFor = Exception.class)  // 예외가 발생했을때 롤백설정
	public void insertBoard(BoardDTO vo) throws Exception {
		
		System.out.println("boardSerive의  insertBoard() 실행");
		boardDAO.insertBoard(vo);  
	}

	@Override
	public void updateBoard(BoardDTO vo) throws Exception {
		boardDAO.updateBoard(vo);		
	}

	@Override
	public void deleteBoard(BoardDTO vo) throws Exception {
		System.out.println("boardSerive의  deleteBoard() 실행");
		boardDAO.deleteBoard(vo);
	}


	@Override
	public BoardDTO getBoard(BoardDTO vo) throws Exception {
		System.out.println("boardSerive의  getBoard() 실행");
		return boardDAO.getBoard(vo);    // returning="returnObj" 
	}


	@Override
	public List<BoardDTO> getBoardList(BoardDTO vo) throws Exception {
		System.out.println("boardSerive의  getBoardList() 실행");
		return boardDAO.getBoardList(vo);  // returning="returnObj" 
	}

}
