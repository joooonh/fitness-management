package com.example.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.example.vo.User;

@Mapper
public interface UserMapper {

	User getUserById(String userId);
	User getUserByEmail(String email);

	void insertUser(User user);
	void updateUser(User user);
	
	
	int getTotalRows();
	
	List<User> getAllUsers();
	
	
	


}
