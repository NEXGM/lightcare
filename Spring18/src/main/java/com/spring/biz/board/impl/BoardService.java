package com.spring.biz.board.impl;

import java.sql.SQLException;
import java.util.List;

import com.spring.biz.common.BoardDTO;

//비즈니스 로직처리  (JSP에서 java파일)
public interface BoardService {

	//글등록
	public void insertBoard(BoardDTO vo) throws Exception;
	//글수정
	public void updateBoard(BoardDTO vo) throws Exception;
	//글삭제
	public void deleteBoard(BoardDTO vo) throws Exception;
	//글상세조회
	public BoardDTO getBoard(BoardDTO vo) throws Exception;
	//글목록조회 
	public List<BoardDTO> getBoardList(BoardDTO vo) throws Exception;
}
