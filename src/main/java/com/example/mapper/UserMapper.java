package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.UserListAttDto;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.User;

@Mapper
public interface UserMapper {

	void insertUser(User user);
	void updateUser(User user);
	User getUserById(String userId);
	User getUserByEmail(String email);
	int getTotalRows();
	List<UserListAttDto> getUserList(Map<String,Object>param);
	List<FitnessProgramCategory> getPrograms();
}
