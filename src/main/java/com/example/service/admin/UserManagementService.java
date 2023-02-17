package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mapper.UserMapper;
import com.example.vo.User;

@Service
@Transactional
public class UserManagementService {

	@Autowired
	UserMapper userMapper;
	
	// 회원 목록 조회
	public Map<String, Object> getUserList(){
		List<User> userList = userMapper.getAllUsers();
		int totalRows = userMapper.getTotalRows();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userList", userList);
		map.put("totalRows", totalRows);
		
		return map;
	}
}
