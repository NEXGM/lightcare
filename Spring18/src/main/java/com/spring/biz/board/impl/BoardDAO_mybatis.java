package com.spring.biz.board.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.biz.common.BoardDTO;

@Repository("boardDAO")
public class BoardDAO_mybatis {

		@Autowired
		SqlSessionTemplate mybatis;
	
	
	//글 등록
		public void insertBoard(BoardDTO vo) {
			// --- *** 여기에 디버깅 로그 추가 *** ---
			System.out.println("MyBatis의 insertBoard()처리 진입!");
			System.out.println("BoardDTO vo (DAO 내부): " + vo.toString());
			System.out.println("DAO에서 받은 제목: " + vo.getTitle());
			System.out.println("DAO에서 받은 작성자: " + vo.getWriter());
			System.out.println("DAO에서 받은 내용: " + vo.getContent());
			// --- *** 디버깅 로그 끝 *** ---
						
			System.out.println("MyBatis의  insertBoard()처리");
			mybatis.insert("BoardDAO.insertBoard", vo);   // 맵퍼  namespace.id
			//mybatis.commit();
		}
		
		//글 수정
		public void updateBoard(BoardDTO vo) {  // update board set title=?,content=? where seq=?
			
			mybatis.insert("BoardDAO.insertBoard", vo);   // 맵퍼  namespace.id
			//mybatis.commit(); // 중요: INSERT 후 commit() 필요!
			System.out.println("MyBatis의 insertBoard()처리 완료!");
		}
		
		//글 삭제
		public void deleteBoard(BoardDTO vo) {   // delete from board where seq=?
			System.out.println("MyBatis의  deleteBoard()처리"); // 로그 추가!
			mybatis.delete("BoardDAO.deleteBoard", vo); // 맵퍼 namespace.id
			//mybatis.commit(); // commit()도 필요!
		}
		
		//글 상세조회
		public BoardDTO getBoard(BoardDTO vo) {   // select * from board where seq=?
			return mybatis.selectOne("BoardDAO.getBoard",vo);
		}
		
		//글 전체조회
		public List<BoardDTO> getBoardList(BoardDTO vo){      //  select * from board order by seq desc
			System.out.println("MyBatis의  getBoardList()처리");
			return mybatis.selectList("BoardDAO.getBoardList",vo);
		}
}
