package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ProgramDto;
import com.example.vo.Program;
import com.example.vo.ProgramCategory;
import com.example.vo.ProgramDay;
import com.example.vo.User;

@Mapper
public interface ProgramMapper {
	
	// 모든 프로그램 목록
	List<Program> getAllPrograms(Map<String, Object> param);
	int getTotalRows(Map<String, Object> rows);
	// 프로그램 상세정보
	ProgramDto getProgramDetail(int programNo);
	// 프로그램 진행 요일
	List<ProgramDay> getProgramDayByProgramNo(int programNo);
	// 프로그램 신청자 목록
	List<User> getUsersByProgramNo(int programNo);
	// 프로그램 분류 목록
	List<ProgramCategory> getProgramCategory();
	// 프로그램 등록
	void insertProgram(Program program);
	// 프로그램 진행 요일 등록
	void insertProgramDays(ProgramDay programDay);
	
}
