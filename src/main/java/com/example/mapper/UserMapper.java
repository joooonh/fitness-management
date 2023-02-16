package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.UserListAttDto;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.User;

@Mapper
public interface UserMapper {

	User getUserById(String userId);
	User getUserByEmail(String email);
	List<User> getAllUsers();
	void insertUser(User user);
	void updateUser(User user);
	int getTotalRows();
	List<UserListAttDto> getUserList(Map<String,Object>param);
	List<FitnessProgramCategory> getPrograms();

}
