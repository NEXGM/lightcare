package com.spring.biz.board.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import com.spring.biz.common.BoardDTO;


//@Repository("boardDAOSpring")
public class BoardDAOSpring {
	
	@Autowired
	JdbcTemplate jdbcTemplate;

	//SQL문
	private final String BOARD_INSERT 
	   = "insert into BOARD(seq,title,regDate,writer,content) "
	   +"values( (select seq from (select IFNULL(max(seq),0)+1 as seq from board) as tmp),?,now(),?,?)" ;
	
	//private final String BOARD_INSERT 
	//	= "insert into BOARD(seq,title,writer,content) values( ?,?,?,?)" ;	
	private final String BOARD_UPDATE
		= "update board set title=?,content=? where seq=?";
	private final String BOARD_DELETE
		= "delete from board where seq=?";
	private final String BOARD_GET
		="select * from board where seq=?";
	
	
	//시작할때 전체검색
	private final String BOARD_LIST
		="select * from board order by seq desc";
	//제목으로 검색할때
	private final String BOARD_LIST_T
		="select * from board   where title  like ? order by seq desc";
	
	//내용으로 검색할때
	private final String BOARD_LIST_C
		="select * from board   where content like ? order by seq desc";
	
	
	//글 등록
	public void insertBoard(BoardDTO vo) throws Exception {
		System.out.println(">>>>> DAO에서  insert() 실행 ");
		jdbcTemplate.update(BOARD_INSERT,vo.getTitle(),vo.getWriter(),vo.getContent());
	}
	
	//글 수정
	public void updateBoard(BoardDTO vo) throws Exception {  // update board set title=?,content=? where seq=?
		System.out.println(">>>>> DAO에서  update() 실행 ");
		jdbcTemplate.update(BOARD_UPDATE, vo.getTitle(), vo.getContent(), vo.getSeq() );
	}
	
	//글 삭제
	public void deleteBoard(BoardDTO vo) throws Exception {   // delete from board where seq=?
		System.out.println(">>>>> DAO에서  delete() 실행 ");
		jdbcTemplate.update(BOARD_DELETE, vo.getSeq() );
	}
	
	//글 상세조회
	public BoardDTO getBoard(BoardDTO vo) throws Exception {   // select * from board where seq=?
		System.out.println(">>>>> DAO에서  getBoard() 실행 ");
		Object[] args = {vo.getSeq()};
		return jdbcTemplate.queryForObject(BOARD_GET, args, new BoardRowMapper() ); // DB>데이터를 세팅한 DTO(VO)
	}
	
	//글 전체조회
	public List<BoardDTO> getBoardList(BoardDTO vo) throws Exception{      //  select * from board order by seq desc
		System.out.println(">>>>> DAO에서  getBoardList() 실행 ");
		
		// 전체검색
		if(vo.getSearchCondition().equals("TITLE") && vo.getSearchKeyword().equals("")  || 
				vo.getSearchCondition().equals("CONTENT") && vo.getSearchKeyword().equals("")) {
			
			return jdbcTemplate.query(BOARD_LIST, new BoardRowMapper());    //전체검색
		}
		
		else {
			Object[] args = {"%"+vo.getSearchKeyword().trim()+"%"} ;  // 이런 문자열이 들어있는것
			
			// 제목검색   
			if(vo.getSearchCondition().equals("TITLE")) {
				return jdbcTemplate.query(BOARD_LIST_T, args ,new BoardRowMapper() );  //제목검색
			}
			// 제목검색
			else if(vo.getSearchCondition().equals("CONTENT")) {
				return jdbcTemplate.query(BOARD_LIST_C, args ,new BoardRowMapper()); // 내용검색
			}
			else {
				return null;
			}
		}
	}
}







