package com.spring.biz.user.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.biz.common.UserDTO;

@Repository("userDAO")
public class UserDAO_mybatis {
	
	@Autowired
	SqlSessionTemplate mybatis;
	
    // 회원 등록
    public void insertUser(UserDTO vo) {
        System.out.println("MyBatis의 insertUser() 처리");
        mybatis.insert("UserDAO.insertUser", vo); // UserDAO 매퍼의 insertUser ID 호출
    }

	// 회원 상세 조회
	public UserDTO getUser(UserDTO vo) {
		System.out.println("MyBatis의 getUser() 처리");
		return mybatis.selectOne("UserDAO.getUser", vo);
	}
	
	// 전체 회원 조회 (회원 목록)
	public List<UserDTO> getUserList(UserDTO vo) {
		System.out.println("MyBatis의 getUserList() 처리");
		return mybatis.selectList("UserDAO.getUserList", vo);
	}
}
