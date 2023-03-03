package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.EmployeeAttDto;
import com.example.vo.Employee;
import com.example.vo.EmployeeAttendance;
import com.example.vo.FitnessProgram;

@Mapper
public interface EmployeeAttMapper {
	
	// 출석 등록하기 
	void insertEmpAttList(EmployeeAttendance emp);
	
	// 페이징
	int getTotalRows(Map<String, Object> param);
	
	// 출석 조회
	List<EmployeeAttDto> getEmpList(Map<String, Object> param);

	// 프로그램 조회
	List<FitnessProgram> getPrograms();
	
	// 강사번호 조회하기
	List<Employee> getEmpId();
	
	// 강사아이디를 조회해서 모달창에 나타내기
	EmployeeAttDto getEmpById(String empId);

}
