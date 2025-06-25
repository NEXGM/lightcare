package com.spring.biz.user.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import com.spring.biz.common.UserDTO;

public class UserRowMapper  implements RowMapper<UserDTO>{

	@Override
	public UserDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		UserDTO user = new UserDTO();
		user.setId(rs.getString("ID"));
		user.setName(rs.getString("NAME"));
		user.setPassword(rs.getString("PASSWORD"));
		user.setRole(rs.getString("ROLE"));
		
		System.out.println("현재 처리중인 행번호: "+ rowNum);
		
		// rowNum의 활용예 - 필요없으면 안사용
		if(rowNum == 0) {
			System.out.println("첫번째 사용자 : "+user.getName());
			if(user.getName().equalsIgnoreCase("홍길동")) {
				user.setRole("슈퍼관리자");
			}
		}
		
		return user;
	}

}
