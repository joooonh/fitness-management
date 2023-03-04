package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dto.EmployeeAttDto;
import com.example.mapper.EmployeeAttMapper;
import com.example.utils.Pagination;
import com.example.vo.Employee;
import com.example.vo.EmployeeAttendance;
import com.example.vo.FitnessProgram;
import com.example.web.request.EmployeeAttRegister;

@Service
public class EmployeeAttService {
	
	@Autowired
	EmployeeAttMapper empAttMapper;
	
	// 출석 등록하기 
	public void insertEmpAttList(EmployeeAttRegister form) {
		EmployeeAttendance emp = new EmployeeAttendance();
		BeanUtils.copyProperties(form, emp);
		empAttMapper.insertEmpAttList(emp);
		
	}
	
	// 출석 조회하기
	public Map<String, Object> getEmpList(Map<String, Object> param) {
		int page = (Integer) param.get("page");
		
		int totalRows = empAttMapper.getTotalRows(param);
		Pagination pagination = new Pagination(page,totalRows);
		
		param.put("begin",pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		List<EmployeeAttDto>  emps = empAttMapper.getEmpList(param);
		
		Map<String,Object> result = new HashMap<>();
		result.put("empAtts",emps);
		result.put("pagination",pagination);

		return result;
	}

	
	// 프로그램 조회하기
	public List<FitnessProgram> getPrograms(){
		
		return empAttMapper.getPrograms();
	}
	
	// 강사 번호 조회하기
	public List<Employee> getEmpId() {
		
		return empAttMapper.getEmpId();
	}
	
	// 강사아이디를 조회해서 모달창에 나타내기
	public EmployeeAttDto getEmpById(String empId) {
		
		return empAttMapper.getEmpById(empId);
	}
	
}
