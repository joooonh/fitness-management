package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ClassRegistrationDto;
import com.example.dto.MembershipDto;
import com.example.dto.UserListAttDto;
import com.example.vo.ClassRegistrationHistory;
import com.example.vo.FitnessProgram;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.Membership;
import com.example.vo.UserAttendance;
import com.example.vo.UserClassAttendance;

@Mapper
public interface UserAttMapper {
	
		// 출석조회
		List<UserListAttDto> getUserList(Map<String,Object>param);
		// 프로그램조회
		List<FitnessProgramCategory> getPrograms();
		// 프로그램요일 조회
		List<String> getProgramDays(int programNo);
		
		//프로그램 번호 조회
		FitnessProgram getProgramByNo(String programNo);
		
		// 회원출석 등록
		void insertUserAtt(UserAttendance userAtt);
		
		// 프로그램 출석 등록
		void insertUserClassAtt(UserClassAttendance classAtt);
		
		int getTotalRows(Map<String,Object>param);

		// 회원출석 삭제
		void deleteUserAtt(int no);
		void deleteClassAtt(int no);
		
		// 모달창에 회원정보 조회하기
		List<Membership> getMembership();
		
		// 회원번호 조회해서 모달창에 나타내기
		MembershipDto getUserByNo(int userNo);
		
		// 프로그램 출석 모달창에 회원정보 조회
		List<ClassRegistrationHistory> getClassRegistration();
		// 프로그램 회원번호 조회해서 모달창에 나타내기
		ClassRegistrationDto getClassUserByNo(int userNo);
		
		

		
}
