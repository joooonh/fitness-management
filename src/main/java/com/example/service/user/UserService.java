package com.example.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ProgramDetailDto;
import com.example.dto.UserListAttDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.mapper.UserMapper;
import com.example.mapper.UserRoleMapper;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgram;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.User;
import com.example.vo.UserAttendance;
import com.example.vo.UserClassAttendance;
import com.example.vo.UserRole;
import com.example.web.request.UserAttRegisterForm;
import com.example.web.request.UserClassAttRegisterForm;
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
	public Map<String,Object> getUserList(int page,String opt,String keyword, String programInfo) {
		Map<String,Object> param = new HashMap<String,Object>();
		if (!opt.isBlank() && !keyword.isBlank() && !programInfo.isBlank()) {
			param.put("opt", opt);
			param.put("keyword", keyword);
			param.put("programInfo", programInfo);
		}

		int totalRows = userMapper.getTotalRows(param);
		Pagination pagination = new Pagination(page,totalRows);
		
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		List<UserListAttDto> users = userMapper.getUserList(param);
		
		Map<String,Object> result = new HashMap<>();
		result.put("userAtts", users );
		result.put("pagination", pagination);
		
		return result;
	}
	

		
	// 프로그램 프로그램명 조회
	public List<FitnessProgramCategory> getPrograms() {
			
		return userMapper.getPrograms();
	}
	
	// 프로그램출석 모달창 - 프로그램 요일 조회
	public ProgramDetailDto getProgramDay(String programNo) {
		FitnessProgram fitpro = userMapper.getProgramByNo(programNo);
		
		ProgramDetailDto programDto = new ProgramDetailDto();
		BeanUtils.copyProperties(fitpro, programDto);
		
		return programDto;
	}


	//회원출석등록
	public void insertUserAtt(UserAttRegisterForm form) {
		
		UserAttendance userAtt = new UserAttendance();
		BeanUtils.copyProperties(form, userAtt );
		userMapper.insertUserAtt(userAtt);
	}
	//프로그램출석등록
	public void insertUserClassAtt(UserClassAttRegisterForm form) {
		
		UserClassAttendance classAtt = new UserClassAttendance();
		BeanUtils.copyProperties(form, classAtt);
		userMapper.insertUserClassAtt(classAtt);
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
