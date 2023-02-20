package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.UserListAttDto;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.User;

@Mapper
public interface UserMapper {

	// 아이디로 사용자 조회
	User getUserById(String userId);
	// 이메일로 사용자 조회
	User getUserByEmail(String email);
	// 모든 사용자 조회
	List<User> getAllUsers();
	// 사용자 추가
	void insertUser(User user);
	// 사용자 정보 변경
	void updateUser(User user);
	
	// 전체 행 조회 
	int getTotalRows();
	// 회원 출석 목록 조회
	List<UserListAttDto> getUserList(Map<String,Object>param);
	// 프로그램 분류 목록 조회
	List<FitnessProgramCategory> getPrograms();
	
}
