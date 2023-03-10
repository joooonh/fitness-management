package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ClassRegHistoryDto;
import com.example.dto.UserListDto;

@Mapper
public interface UserListMapper {

	// 검색 조건에 해당하는 회원 목록 전체 행 조회
	int getUserListTotalRows(Map<String, Object> rows);
	// 전체 회원 목록 조회 
	List<UserListDto> getUserListDto(Map<String, Object> param);
	// 회원별 신청한 프로그램명 조회
	List<ClassRegHistoryDto> getProgramNameByUserNo(int userNo);
}
