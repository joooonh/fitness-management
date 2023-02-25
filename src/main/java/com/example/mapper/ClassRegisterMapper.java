package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.Program;

@Mapper
public interface ClassRegisterMapper {

	// 전체 프로그램 조회
	List<Program> getAllPrograms();
	// 프로그램별 요일 조회
	List<String> getAllProgramDays(int progNo);
	// 프로그램 신청(추가)
	void insertClassRegistration(Map<String, Object> param);
	// 회원권 신청(추가)
	void insertMembership(Map<String, Object> param);
	
}
