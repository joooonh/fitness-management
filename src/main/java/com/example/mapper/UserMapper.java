package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ProgramDetailDto;
import com.example.dto.UserListAttDto;
import com.example.vo.FitnessProgram;

import com.example.vo.FitnessProgramCategory;
import com.example.vo.User;
import com.example.vo.UserAttendance;
import com.example.vo.UserClassAttendance;

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
	// 프로그램 신청
	void registerClass(String userId);
	// 회원권 신청
	void registerMemvership(String userId);
	
	
	// 모든 사용자 조회
	int getTotalRows(Map<String,Object> param);
	// 출석 조회
	List<UserListAttDto> getUserList(Map<String,Object> param);
	// 프로그램 분류 목록 조회
	List<FitnessProgramCategory> getPrograms();
	// 프로그램요일 조회
	List<ProgramDetailDto> getProgramDays();
	//프로그램 번호 조회
	FitnessProgram getProgramByNo(String programNo);
	// 회원출석 등록
	void insertUserAtt(UserAttendance userAtt);
	// 프로그램 출석 등록
	void insertUserClassAtt(UserClassAttendance classAtt);
	int getTotalRows();

}
