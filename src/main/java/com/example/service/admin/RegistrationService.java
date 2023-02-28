package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ClassRegistrationDto;
import com.example.dto.MembershipDto;
import com.example.mapper.RegistrationMapper;
import com.example.utils.Pagination;
import com.example.web.request.MembershipSearch;

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
	public Map<String, Object> getAllMembership(int page,MembershipSearch search) {
		// 검색조건에 해당하는 행의 갯수 조회
		Map<String, Object> rows = new HashMap<>();
		rows.put("startDate", search.getStartDate());
		rows.put("endDate", search.getEndDate());
		rows.put("period", search.getPeriod());
		rows.put("keyword", search.getKeyword());
		int totalRows = registrationMapper.getTotalRows(rows);
		
		Pagination pagination = new Pagination(page, totalRows);
		// 검색조건을 Map객체에 담아서 전달
		Map<String, Object> param = new HashMap<>();
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		param.put("startDate", search.getStartDate());
		param.put("endDate", search.getEndDate());
		param.put("period", search.getPeriod());
		param.put("keyword", search.getKeyword());
		
		List<MembershipDto> membership = registrationMapper.getAllMembership(param);
		
		Map<String, Object> result = new HashMap<>();
		result.put("membershipList", membership);
		result.put("pagination", pagination);
		
		return result;
	}
}
