package com.spring.biz.user.impl;

import java.util.List;
import com.spring.biz.common.UserDTO;

public interface UserService {

	public UserDTO getUser(UserDTO vo) throws Exception;
	public List<UserDTO> getUserList(UserDTO vo) throws Exception;
    public void insertUser(UserDTO vo) throws Exception; // 회원가입 메서드 추가
	
}
