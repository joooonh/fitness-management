package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ProgramDetailDto;
import com.example.dto.UserListAttDto;
import com.example.exception.ApplicationException;
import com.example.mapper.UserAttMapper;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgram;
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
	public Map<String,Object> getUserList(int page,String opt,String keyword, String programInfo) {
		Map<String,Object> param = new HashMap<String,Object>();
		if (!opt.isBlank() && !keyword.isBlank() && !programInfo.isBlank()) {
			param.put("opt", opt);
			param.put("keyword", keyword);
			param.put("programInfo", programInfo);
		}

		int totalRows = userAttMapper.getTotalRows(param);
		Pagination pagination = new Pagination(page,totalRows);
		
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		List<UserListAttDto> users = userAttMapper.getUserList(param);
		
		Map<String,Object> result = new HashMap<>();
		result.put("userAtts", users );
		result.put("pagination", pagination);
		
		return result;
	}
	

		
	// 프로그램 프로그램명 조회
	public List<FitnessProgramCategory> getPrograms() {
			
		return userAttMapper.getPrograms();
	}
	
	// 프로그램출석 모달창 - 프로그램 요일 조회
	public ProgramDetailDto getProgramDay(String programNo) {
		FitnessProgram fitpro = userAttMapper.getProgramByNo(programNo);
		
		ProgramDetailDto programDto = new ProgramDetailDto();
		BeanUtils.copyProperties(fitpro, programDto);
		
		return programDto;
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
	
	
	// 출석글 삭제
	public void deleteAtt(int userNo) {
		
		UserAttendance userAtt = userAttMapper.getUserAttByNo(userNo);
		if(userAtt == null) {
			throw new ApplicationException("["+userNo+"]번 회원은 없습니다.");
		}
		userAttMapper.deleteUserAtt(userNo);
		
	}
	
}
