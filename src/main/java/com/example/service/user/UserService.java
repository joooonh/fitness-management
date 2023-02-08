package com.example.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.jdt.core.compiler.CategorizedProblem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.UserListAttDto;
import com.example.mapper.UserMapper;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgramCategory;

@Service
@Transactional
public class UserService {
	
	@Autowired
	private UserMapper userMapper;
	
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
	
}
