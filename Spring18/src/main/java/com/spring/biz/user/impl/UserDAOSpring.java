package com.spring.biz.user.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.spring.biz.common.UserDTO;


//@Repository("userDAOSpring")
public class UserDAOSpring {
	
	@Autowired
	JdbcTemplate jdbcTemplate;

	private Connection  conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private final String USER_GET  = "select * from users where id=? and password=?";
	private final String USER_LIST = "select * from users order by id desc";
	
	
	//회원조회
	public UserDTO getUser(UserDTO vo) throws Exception {
		
		Object[] args = {vo.getId(), vo.getPassword()};
		return jdbcTemplate.queryForObject(USER_GET, args, new UserRowMapper());
		
	}
	
	//전체회원조회
	
	public ArrayList<UserDTO> getUserList() throws Exception{
		return (ArrayList<UserDTO>)jdbcTemplate.query(USER_LIST, new UserRowMapper());
	}	
	
}










