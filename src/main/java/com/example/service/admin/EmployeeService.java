package com.example.service.admin;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.EmployeeDetail;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.EmployeeRoleMapper;
import com.example.vo.Employee;
import com.example.vo.EmployeeRole;
import com.example.web.request.EmployeeModifyForm;


@Service
@Transactional
public class EmployeeService {

	@Autowired 
	EmployeeMapper employeeMapper;
	@Autowired
	EmployeeRoleMapper employeeRoleMapper;
	
	public Employee getEmployee(String empId) {
		return employeeMapper.getEmployeeById(empId);
	}
	
	public EmployeeDetail getEmployeeDetail(String empId) {
		// 직원아이디로 직원정보, 직원권한을 조회한다.
		Employee employee = employeeMapper.getEmployeeById(empId);
		List<EmployeeRole> employeeRole = employeeRoleMapper.getEmployeeRoles(empId);
		
		// 조회한 직원정보, 직원권한을 EmployeeDetail에 대입한다.
		EmployeeDetail employeeDetail = new EmployeeDetail();
		BeanUtils.copyProperties(employee, employeeDetail);
		employeeDetail.setEmployeeRole(employeeRole);
		
		return employeeDetail;
	}
	
	public void updateEmployee(EmployeeModifyForm form) {
		Employee employee = employeeMapper.getEmployeeById(form.getId());
		BeanUtils.copyProperties(form, employee);
		
		employeeMapper.updateEmployee(employee);
	}
}
