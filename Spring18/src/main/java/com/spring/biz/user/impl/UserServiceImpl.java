package com.spring.biz.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.biz.common.UserDTO;

@Service("userService")
@Transactional(rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAO_mybatis userDAO;

    @Transactional // 회원가입 트랜잭션 적용
    @Override
    public void insertUser(UserDTO vo) throws Exception {
        System.out.println("--- UserServiceImpl - insertUser 호출 ---");
        userDAO.insertUser(vo);
    }

	@Transactional(readOnly = true)
	@Override
	public UserDTO getUser(UserDTO vo) throws Exception {
		System.out.println("--- UserServiceImpl - getUser 호출 ---");
		return userDAO.getUser(vo);
	}

	@Transactional(readOnly = true)
	@Override
	public List<UserDTO> getUserList(UserDTO vo) throws Exception {
		System.out.println("--- UserServiceImpl - getUserList 호출 ---");
		return userDAO.getUserList(vo);
	}

}
