package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.EmployeeDetail;
import com.example.vo.Employee;

@Mapper
public interface EmployeeMapper {
	
	// 직원 목록 조회
	List<Employee> getAllEmployee(Map<String, Object> param);
	// 직원 목록 갯수
	Integer getTotalRows(Map<String, Object> rows);
	// 직원아이디로 직원정보 조회
	Employee getEmployeeById(String empId);
	// 직원아이디로 직원 상세정보 조회
	EmployeeDetail getEmployeeDetail(String empId);
	// 직원정보 업데이트
	void updateEmployee(Employee employee);
	// 재직중인 직원 
	List<Employee> getEmployeeByStatus();
	// 직원이름으로 검색한 직원 정보
	List<Employee> getSearchEmployees(String employeeName);
	// 직원 등록
	void insertEmployee(Employee employee);
}
