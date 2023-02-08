package com.example.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.UserRole;

@Mapper
public interface UserRoleMapper {

	void insertUserRole(UserRole userRole);
	UserRole getUserRoleByNo(int userNo);
}
