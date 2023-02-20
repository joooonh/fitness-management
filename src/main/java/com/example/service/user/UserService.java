package com.example.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ClassRegHistoryDto;
import com.example.dto.ConsultingHistoryDto;
import com.example.dto.UserListAttDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.exception.AlreadyRegisteredUserIdException;
import com.example.exception.ApplicationException;
import com.example.exception.InconsistentPasswordException;
import com.example.mapper.UserMapper;
import com.example.mapper.UserMypageMapper;
import com.example.mapper.UserRoleMapper;
import com.example.vo.MembershipHistory;
import com.example.vo.ProgramDay;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgramCategory;
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
	UserMypageMapper userMypageMapper;
	
	
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
		
		List<MembershipHistory> membershipList = userMypageMapper.getAllMembershipsByUserNo(user.getNo());
		
		return membershipList;
	}
	
	// 수업신청내역, 상담예약 조회
	public Map<String, Object> getRegistrationHistory(String userId){
		
		User user = userMapper.getUserById(userId);
		if(user == null) {
			throw new ApplicationException("[" + userId + "] 존재하지 않는 아이디입니다.");
		}
		
		// 수업 신청 내역 조회
		List<ClassRegHistoryDto> classRegList = userMypageMapper.getAllClassRegHistoriesDtoByUserNo(user.getNo());
		for(ClassRegHistoryDto dto : classRegList) {
			List<ProgramDay> openDay = userMypageMapper.getProgramDayByProgramNo(dto.getProgramNo()); // [화, 목]
			dto.setOpenDay(openDay);
		}
		// 상담 예약 내역 조회
		List<ConsultingHistoryDto> consultingList = userMypageMapper.getAllConsultingHistoryDtosByUserNo(user.getNo());
		
		Map<String, Object> map = new HashMap<>();
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
