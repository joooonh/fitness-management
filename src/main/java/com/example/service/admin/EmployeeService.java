package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.EmployeeDetail;
import com.example.exception.ApplicationException;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.utils.Pagination;
import com.example.vo.Employee;
import com.example.vo.EmployeeRole;
import com.example.web.request.EmployeeModifyForm;
import com.example.web.request.EmployeeRegisterForm;


@Service
@Transactional
public class EmployeeService {

	@Autowired 
	EmployeeMapper employeeMapper;
	@Autowired
	EmployeeRoleMapper employeeRoleMapper;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	// 모든 직원 정보 조회
	public Map<String, Object> getAllEmployee(int page, String status, String keyword) {
		// 검색 조건에 해당하는 직원 목록 갯수 조회
		Map<String, Object> rows = new HashMap<>();
		rows.put("status", status);
		rows.put("keyword", keyword);
		int totalRows = employeeMapper.getTotalRows(rows);
		
		Pagination pagination = new Pagination(page, totalRows);
		
		Map<String, Object> param = new HashMap<>();
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		param.put("keyword", keyword);
		param.put("status", status);
		
		List<Employee> employees = employeeMapper.getAllEmployee(param);
		
		Map<String, Object> result = new HashMap<>();
		result.put("employees", employees);
		result.put("pagination", pagination);
		
		return result;
	}
	
	// 아이디로 직원 정보 조회
	public Employee getEmployeeById(String empId) {
		return employeeMapper.getEmployeeById(empId);
	}
	
	// 아이디로 직원 상세정보 조회
	public EmployeeDetail getEmployeeDetail(String empId) {
		// 직원아이디로 직원정보, 직원권한을 조회한다.
		Employee employee = employeeMapper.getEmployeeById(empId);
		List<EmployeeRole> employeeRole = employeeRoleMapper.getEmployeeRolesByEmployeeId(empId);
		
		// 조회한 직원정보, 직원권한을 EmployeeDetail에 대입한다.
		EmployeeDetail employeeDetail = new EmployeeDetail();
		BeanUtils.copyProperties(employee, employeeDetail);
		employeeDetail.setEmployeeRole(employeeRole);
		
		return employeeDetail;
	}
	
	// 직원 정보 수정
	public void updateEmployee(EmployeeModifyForm form) {
		Employee employee = employeeMapper.getEmployeeById(form.getId());
		String originalPassword = employee.getPassword();
		
		BeanUtils.copyProperties(form, employee);
		
		// 비밀번호가 빈칸이 아니면 비밀번호를 암호화한다.
		if (!form.getPassword().isBlank()) {
			// 비밀번호 암호화
			employee.setPassword(passwordEncoder.encode(form.getPassword()));			
		} else {
			// 비밀번호가 빈칸이면 원래 비밀번호를 설정한다. 
			employee.setPassword(originalPassword);
		}
		
		employeeMapper.updateEmployee(employee);
	}
	
	// 검색한 직원 정보
	public List<Employee> getSearchEmployees(String employeeName) {
		List<Employee> employeeList = employeeMapper.getSearchEmployees(employeeName);
		return employeeList;
	}
	
	// 재직중인 직원 정보
	public List<Employee> getEmployeeByStatus() {
		return employeeMapper.getEmployeeByStatus();
	}

	// 직원 등록
	public void insertEmployee(EmployeeRegisterForm employeeRegisterForm) {
		// 입력받은 아이디로 직원 정보를 조회
		Employee existEmp = employeeMapper.getEmployeeById(employeeRegisterForm.getId());
		// 아이디로 조회한 직원 정보가 있으면 예외를 던진다.
		if (existEmp != null) {
			throw new ApplicationException("이미 존재하는 아이디 입니다.");
		}
		// 입력받은 이메일로 직원 정보를 조회
		existEmp = employeeMapper.getEmployeeByEmail(employeeRegisterForm.getEmail());
		// 이메일로 조회한 직원 정보가 있으면 예외를 던진다.
		if (existEmp != null) {
			throw new ApplicationException("이미 존재하는 이메일 입니다.");
		}
		
		Employee employee = new Employee();
		BeanUtils.copyProperties(employeeRegisterForm, employee);
		// 비밀번호 암호화
		employee.setPassword(passwordEncoder.encode(employeeRegisterForm.getPassword()));
		
		// 직원 정보를 등록한다.
		employeeMapper.insertEmployee(employee);
		// 직원 권한을 등록한다.
		employeeRoleMapper.insertEmployeeRole(employeeRegisterForm.getId());
	}

	// 직원 삭제
	public void deleteEmployee(String empId) {
		String[] employeeIdList = empId.split(",");
		for(String employeeId : employeeIdList) {
			employeeMapper.deleteEmployee(employeeId);
		}
	}
}
