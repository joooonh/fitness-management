package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ProgramDetailDto;
import com.example.dto.UserListAttDto;
import com.example.vo.FitnessProgram;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.UserAttendance;
import com.example.vo.UserClassAttendance;

@Mapper
public interface UserAttMapper {
	
		// 출석조회
		
		List<UserListAttDto> getUserList(Map<String,Object>param);
		// 프로그램조회
		List<FitnessProgramCategory> getPrograms();
		// 프로그램요일 조회
		List<ProgramDetailDto> getProgramDays();
		
		//프로그램 번호 조회
		FitnessProgram getProgramByNo(String programNo);
		
		// 회원출석 등록
		void insertUserAtt(UserAttendance userAtt);
		// 프로그램 출석 등록
		void insertUserClassAtt(UserClassAttendance classAtt);
		
		int getTotalRows(Map<String,Object>param);

		// 회원번호 조회
		UserAttendance getUserAttByNo(int userNo);
		
		// userNo번 회원출석 삭제
		void deleteUserAtt(int userNo);
		
}
