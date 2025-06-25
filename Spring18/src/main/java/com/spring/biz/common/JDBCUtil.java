package com.spring.biz.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCUtil {

	// 컨넥션 가져오기    >>  클래스명.메서드명()  다른 클래스에서 직접 호출사용할 수 있다.
	//                                   공유할수있다. 
	public static Connection getConnection() {  // JDBC.getConnection()
		
		// 입출력(스캐너, DB읽고쓰기 등)은 예외처리(try~ catch문 안에서 작성한다)
		try {			
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection("jdbc:mysql://localhost:3306/studydb?useSSL=false","root","mysql");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 저장하는 닫기
	public static void close(PreparedStatement pstmt, Connection conn) {
		//PreparedStatement 닫기
		if(pstmt != null) {   // pstmt객체가 있고
			try {
				if(!pstmt.isClosed())  pstmt.close();  // 아직 닫히지 않았다면				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				pstmt = null;
			}			
		}
		
		//Connection 닫기
		if(conn != null) {
			try {
				if(!conn.isClosed()) conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				conn = null;
			}
		}
	}
	
	// 읽어왔을때 닫기
	public static void close(ResultSet rs,  PreparedStatement pstmt, Connection conn) {
		
		//ResultSet닫기
		if(rs != null) {   // rs객체가 있고
			try {
				if(!rs.isClosed())  rs.close();  // 아직 닫히지 않았다면				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				rs = null;
			}			
		}
		
		//PreparedStatement 닫기
		if(pstmt != null) {   // stmt객체가 있고
			try {
				if(!pstmt.isClosed())  pstmt.close();  // 아직 닫히지 않았다면				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				pstmt = null;
			}			
		}
		
		//Connection 닫기
		if(conn != null) {
			try {
				if(!conn.isClosed()) conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				conn = null;
			}
		}
	}
	
}










