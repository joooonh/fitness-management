package com.example.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ClassRegistrationDto;
import com.example.dto.MembershipDto;
import com.example.mapper.RegistrationMapper;

@Service
@Transactional
public class RegistrationService {

	@Autowired
	RegistrationMapper registrationMapper;
	
	// 프로그램을 신청한 신청자 조회
	public List<ClassRegistrationDto> getCclassRegistrationUserListByNo(int programNo) {
		return registrationMapper.getCclassRegistrationUserListByNo(programNo);
	}
	
	// 회원권 목록 조회
	public List<MembershipDto> getAllMembership() {
		return registrationMapper.getAllMembership();
	}
}
