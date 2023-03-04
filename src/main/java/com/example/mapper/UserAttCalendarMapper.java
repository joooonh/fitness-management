package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.dto.AttEvent;
import com.example.dto.UserListAttDto;
import com.example.vo.FitnessProgramCategory;

@Mapper
public interface UserAttCalendarMapper {

			// 출석조회
			List<UserListAttDto> getUserList(Map<String,Object>param);
			
			int getTotalRows(Map<String,Object>param);
			
			// 프로그램 조회
			List<FitnessProgramCategory> getPrograms();
			
			// 달력 조회
			List<AttEvent> getAttEvents(Map<String, Object>param);
			
			// 회원 아이디 조회
			UserListAttDto getUserById(Map<String, Object> param);
			
			// 달력
			List<AttEvent> getEvents(String userNo);
			
			
}
