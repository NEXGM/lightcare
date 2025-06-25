package com.spring.biz.board.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.biz.common.BoardDTO;
import com.spring.biz.common.JDBCUtil;


//@Component("boardDAO")
//@Repository("boardDAO")
public class BoardDAO {
	
	//@Autowired
	//JDBCUtil ds;
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//SQL문
	private final String BOARD_INSERT 
		= "insert into BOARD(seq,title,writer,content) "
		    +"values( (select seq from (select IFNULL(max(seq),0)+1 as seq from board) as tmp),?,?,?)" ;
	private final String BOARD_UPDATE
		= "update board set title=?,content=? where seq=?";
	private final String BOARD_DELETE
		= "delete from board where seq=?";
	private final String BOARD_GET
		="select * from board where seq=?";
	private final String BOARD_LIST
		="select * from board order by seq desc";
			
	//글 등록
	public void insertBoard(BoardDTO vo) {
		
		try {
			conn = JDBCUtil.getConnection();
			
			pstmt = conn.prepareStatement(BOARD_INSERT);
			pstmt.setString(1,vo.getTitle());
			pstmt.setString(2, vo.getWriter());
			pstmt.setString(3,vo.getContent());
			
			//DB처리
			int n = pstmt.executeUpdate();
			if(n>0) {
				System.out.println("데이터 등록을 성공하였습니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt, conn);
		}
	}
	
	//글 수정
	public void updateBoard(BoardDTO vo) {  // update board set title=?,content=? where seq=?
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(BOARD_UPDATE);
			pstmt.setString(1,vo.getTitle());
			pstmt.setString(2,vo.getContent());
			pstmt.setInt(3,vo.getSeq());
			
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt,conn);
		}
	}
	
	//글 삭제
	public void deleteBoard(BoardDTO vo) {   // delete from board where seq=?
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(BOARD_DELETE);
			pstmt.setInt(1, vo.getSeq());
			
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt,conn);
		}
	}
	
	//글 상세조회
	public BoardDTO getBoard(BoardDTO vo) {   // select * from board where seq=?
		BoardDTO board = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(BOARD_GET);
			pstmt.setInt(1,vo.getSeq());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board = new BoardDTO();
				board.setSeq(rs.getInt("SEQ"));
				board.setTitle(rs.getString("TITLE"));     // 수정
				board.setWriter(rs.getString("WRITER"));   // 수정
				board.setContent(rs.getString("CONTENT"));
				board.setRegDate(rs.getDate("REGDATE"));
				board.setCnt(rs.getInt("CNT"));
			}
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return board;
	}
	
	//글 전체조회
	public List<BoardDTO> getBoardList(){      //  select * from board order by seq desc
		
		//   부모                                                 자식 
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(BOARD_LIST);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setSeq(rs.getInt("SEQ"));
				board.setTitle(rs.getString("TITLE"));     // 수정
				board.setWriter(rs.getString("WRITER"));   // 수정
				board.setContent(rs.getString("CONTENT"));
				board.setRegDate(rs.getDate("REGDATE"));
				board.setCnt(rs.getInt("CNT"));
				
				boardList.add(board);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		
		return boardList;
	}
}







