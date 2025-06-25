package com.spring.biz.user.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;
import com.spring.biz.common.UserDTO;


//@Repository("userDAO")
public class UserDAO {	
	
	private Connection  conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private final String USER_GET  = "select * from users where id=? and password=?";
	private final String USER_LIST = "select * from users order by id desc";
	
	//회원등록
	public UserDTO getUser(UserDTO vo) {
		
		// MySQL의 테이블을 참고하고 ,  DTO를 참고해서  여기 코드를 작성  + BoardDAO도 참고
		
		UserDTO user = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(USER_GET);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPassword());  // 완성

			//실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user = new UserDTO();
				user.setId(rs.getString("ID"));
				user.setName(rs.getString("NAME"));
				user.setPassword(rs.getString("PASSWORD"));
				user.setRole(rs.getString("ROLE"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return user;
	}
	
	//전체회원조회
	public ArrayList<UserDTO> getUserList(){
		
		// MySQL의 테이블을 참고하고 ,  DTO를 참고해서  여기 코드를 작성  + BoardDAO도 참고
		ArrayList<UserDTO> userList = new ArrayList<UserDTO>();
		try {
			conn =JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(USER_LIST);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserDTO user = new UserDTO();
				user = new UserDTO();
				user.setId(rs.getString("ID"));
				user.setName(rs.getString("NAME"));
				user.setPassword(rs.getString("PASSWORD"));
				user.setRole(rs.getString("ROLE"));
				
				userList.add(user);				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return userList;
	}	
}