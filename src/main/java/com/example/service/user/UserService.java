package com.example.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.exception.ApplicationException;
import com.example.exception.InconsistentPasswordException;
import com.example.mapper.ClassRegistrationHistoryMapper;
import com.example.mapper.FitnessVisitantMapper;
import com.example.mapper.MembershipHistoryMapper;
import com.example.mapper.UserMapper;
import com.example.mapper.UserRoleMapper;
import com.example.vo.ClassRegistrationHistory;
import com.example.vo.FitnessVisitant;
import com.example.vo.MembershipHistory;
import com.example.vo.User;
import com.example.vo.UserRole;
import com.example.web.request.UserModifyForm;
import com.example.web.request.UserRegisterForm;

@Service
@Transactional
public class UserService {

	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	UserMapper userMapper;
	@Autowired
	UserRoleMapper userRoleMapper;
	@Autowired
	MembershipHistoryMapper membershipMapper;
	@Autowired
	ClassRegistrationHistoryMapper classRegMapper;
	@Autowired
	FitnessVisitantMapper visitantMapper;
	
	
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
		if(!userRegisterForm.getEncryptPassword().equals(userRegisterForm.getPasswordConfirm())) {
			throw new InconsistentPasswordException("비밀번호가 일치하지 않습니다.");
		}
		
		User user = new User();
		BeanUtils.copyProperties(userRegisterForm, user);
		
		user.setEncryptPassword(passwordEncoder.encode(userRegisterForm.getEncryptPassword()));
		userMapper.insertUser(user);
		
		UserRole userRole = new UserRole(user.getNo(), "ROLE_USER");
		userRoleMapper.insertUserRole(userRole);
	}
	
	// 내 정보 조회
	public User getUserinfo(String userId) {
		User user = userMapper.getUserById(userId);
		if(user == null) {
			throw new ApplicationException("[" + userId + "] 존재하지 않는 아이디입니다.");
		}
		return user;
	}
	
	// 내 정보 수정
	public User modifyUser(UserModifyForm userModifyForm) {
		if(!userModifyForm.getPassword().equals(userModifyForm.getPasswordConfirm())) {
			throw new InconsistentPasswordException("비밀번호가 일치하지 않습니다.");
		}
		
		User user = userMapper.getUserById(userModifyForm.getId());
		BeanUtils.copyProperties(userModifyForm, user);
		user.setEncryptPassword(passwordEncoder.encode(userModifyForm.getPassword()));
		
		userMapper.updateUser(user);
		return user;
	}
	
	// 회원권 조회
	public List<MembershipHistory> getMembershipHistory(String userId){
		
		User user = userMapper.getUserById(userId);
		if(user == null) {
			throw new ApplicationException("[" + userId + "] 존재하지 않는 아이디입니다.");
		}
		
		List<MembershipHistory> membershipList = membershipMapper.getAllMembershipsByUserNo(user.getNo());
		
		return membershipList;
	}
	
	// 수업신청내역, 상담예약 조회
	public Map<String, Object> getClassRegHistory(String userId){
		
		User user = userMapper.getUserById(userId);
		if(user == null) {
			throw new ApplicationException("[" + userId + "] 존재하지 않는 아이디입니다.");
		}
		
		List<ClassRegistrationHistory> classRegList = classRegMapper.getAllClassRegistrationHistoryByUserNo(user.getNo());
		List<FitnessVisitant> consultingList = visitantMapper.getAllFitnessVisitantsByUserNo(user.getNo());
		// map에 담아서 map을 반환하기 ( *** 수업프로그램도 map에 넣어야함 !! ) 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("classRegList", classRegList);
		map.put("consultingList", consultingList);
		
		return map;
	}
	
	// 회원탈퇴
	public void deleteUser(String userId, String password) {
		User user = userMapper.getUserById(userId);
		if(user == null) {
			throw new ApplicationException("[" + userId + "] 존재하지 않는 아이디입니다.");
		}
		
		// 암호화된 비밀번호를 비교할 때는 Password의 matches(rawPassword, encryptPassword); (전용메소드)
		if(!passwordEncoder.matches(password, user.getEncryptPassword())) {
			throw new ApplicationException("비밀번호가 일치하지 않습니다.");
		}
		
		user.setDeleted("Y");
		userMapper.updateUser(user);
		
	}
	
	
	
	
}