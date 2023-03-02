package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.UserListAttDto;
import com.example.mapper.UserAttMapper;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.UserAttendance;
import com.example.vo.UserClassAttendance;
import com.example.web.request.UserAttRegisterForm;
import com.example.web.request.UserClassAttRegisterForm;

@Service
@Transactional
public class UserAttService {

	@Autowired
	UserAttMapper userAttMapper;
	
	//출석리스트 조회
	public Map<String,Object> getUserList(Map<String, Object> param) {
		
		int page = (Integer) param.get("page");
		
		int totalRows = userAttMapper.getTotalRows(param);
		Pagination pagination = new Pagination(page,totalRows);
		
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		List<UserListAttDto> users = userAttMapper.getUserList(param);
		
		Map<String,Object> result = new HashMap<>();
		result.put("userAtts", users );
		result.put("pagination", pagination);
		result.put("totalRows", totalRows);
		return result;
	}
	

		
	// 프로그램 조회
	public List<FitnessProgramCategory> getPrograms() {
			
		return userAttMapper.getPrograms();
	}
	
	// 프로그램출석 모달창 - 프로그램 요일 조회
	public List<String> getProgramDays(int programNo) {
		
		return userAttMapper.getProgramDays(programNo);
	}


	//회원출석등록
	public void insertUserAtt(UserAttRegisterForm form) {
		
		UserAttendance userAtt = new UserAttendance();
		BeanUtils.copyProperties(form, userAtt );
		userAttMapper.insertUserAtt(userAtt);
	}
	//프로그램출석등록
	public void insertUserClassAtt(UserClassAttRegisterForm form) {
		
		UserClassAttendance classAtt = new UserClassAttendance();
		BeanUtils.copyProperties(form, classAtt);
		userAttMapper.insertUserClassAtt(classAtt);
	}
	
	// 회원출석글 삭제
	public void deleteAtt(List<String> values) {
	
		// values -> ["100-P", "102-P", "301-M",  "300-M"]
		
		for (String text : values) {
			String[] items = text.split("-");
			int no = Integer.parseInt(items[0]);
			String gubun = items[1];
			
			if ("M".equals(gubun)) {
				userAttMapper.deleteUserAtt(no);	
			} else if ("P".equals(gubun)) {
				userAttMapper.deleteClassAtt(no);
			}
		}
		
	}
	
	
}
