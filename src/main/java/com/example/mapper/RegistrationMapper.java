package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ClassRegistrationDto;
import com.example.dto.MembershipDto;

@Mapper
public interface RegistrationMapper {
	
	// 프로그램을 신청한 신청자 조회
	List<ClassRegistrationDto> getCclassRegistrationUserListByNo(int programNo);
	// 회원권 목록 조회
	List<MembershipDto> getAllMembership();
	
}
