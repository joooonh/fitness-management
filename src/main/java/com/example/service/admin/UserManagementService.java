package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.UserListDto;
import com.example.mapper.UserListMapper;
import com.example.mapper.UserMapper;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgram;

@Service
@Transactional
public class UserManagementService {

	@Autowired
	UserMapper userMapper;
	@Autowired
	UserListMapper userListMapper;
	
	// 회원 목록 조회 (전체 회원, 검색어에 해당하는 회원)
	public Map<String, Object> getUserList(int page, int programNo, String keyword){
		
		// 전체 프로그램 목록(검색용)
		List<FitnessProgram> programList = userListMapper.getAllPrograms();
		
		// 프로그램번호, 키워드가 비어있지 않으면 -> param 에 담아서 보냄
		Map<String, Object> param = new HashMap<>();
		if (programNo != 0) {
			param.put("programNo", programNo);			
		}
		if (!keyword.isBlank()) {
			param.put("keyword", keyword);			
		}
		
		// 검색 조건에 해당하는 전체 행 개수
		int totalRows = userListMapper.getUserListTotalRows(param);
		// 페이징 객체 생성 후 param에 begin, end 값 담기
		Pagination pagination = new Pagination(page, totalRows);
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		// 검색 조건에 해당하는 회원 목록
		List<UserListDto> userList = userListMapper.getUserListDto(param);
		
		// 컨트롤러로 보낼 map 객체 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("programList", programList);
		map.put("userList", userList);
		map.put("totalRows", totalRows);
		map.put("pagination", pagination);
		
		return map;
	}
	
	
}
