package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ClassRegistrationDto;
import com.example.dto.MembershipDto;

@Mapper
public interface RegistrationMapper {
	
	// 프로그램을 신청한 신청자 조회
	List<ClassRegistrationDto> getCclassRegistrationUserListByNo(int programNo);
	// 회원권 목록 조회
	List<MembershipDto> getAllMembership(Map<String, Object> param);
	// 검색조건에 해당하는 행의 갯수 조회
	int getTotalRows(Map<String, Object> rows);
	
}
