package com.spring.biz.board.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.spring.biz.common.BoardDTO;

public class BoardRowMapper implements RowMapper<BoardDTO> {

	@Override
	public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		BoardDTO board = new BoardDTO(); // 빈 객체
		
		System.out.println("여기1");
		board.setSeq(rs.getInt("SEQ"));
		board.setTitle(rs.getString("TITLE"));
		board.setWriter(rs.getString("WRITER"));
		board.setContent(rs.getString("CONTENT"));
		board.setRegDate(rs.getDate("REGDATE"));
		board.setCnt(rs.getInt("CNT"));
		
		return board;
	}

}
