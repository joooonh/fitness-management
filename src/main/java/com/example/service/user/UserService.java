package com.example.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.UserListAttDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.mapper.UserMapper;
import com.example.mapper.UserRoleMapper;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.User;
import com.example.vo.UserRole;
import com.example.web.request.UserRegisterForm;

@Service
@Transactional
public class UserService {
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	//출석리스트 조회
	public Map<String,Object> getUserList(int page) {
		int totalRows = userMapper.getTotalRows();
		Pagination pagination = new Pagination(page,totalRows);
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		List<UserListAttDto> users = userMapper.getUserList(param);
		
		Map<String,Object> result = new HashMap<>();
		result.put("userAtts", users );
		result.put("pagination", pagination);
		
		
		return result;
	}
	
	
	public List<FitnessProgramCategory> getPrograms() {
		
		return userMapper.getPrograms();
	}
	

	
	// 회원가입
	public void registerUser(UserRegisterForm userRegisterForm) {
		User savedUser = userMapper.getUserById(userRegisterForm.getId());
		if(savedUser != null) {
			throw new AlreadyRegisteredUserIdException("[" + userRegisterForm.getId() + "] 사용할 수 없는 아이디입니다.");
		}
		savedUser = userMapper.getUserByEmail(userRegisterForm.getEmail());
		if(savedUser != null) {
			throw new AlreadyRegisteredEmailException("[" + userRegisterForm.getEmail() + "] 사용할 수 없는 이메일입니다.");
		}
		
		User user = new User();
		BeanUtils.copyProperties(userRegisterForm, user);
		
		user.setEncryptPassword(passwordEncoder.encode(userRegisterForm.getEncryptPassword()));
		userMapper.insertUser(user);
		
		UserRole userRole = new UserRole(user.getNo(), "ROLE_USER");
		userRoleMapper.insertUserRole(userRole);
	}
}
