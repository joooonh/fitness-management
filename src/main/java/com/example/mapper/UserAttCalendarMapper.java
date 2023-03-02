package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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
			UserListAttDto getUserByNo(String userNo);
			
			// 달력에 조회할 회원 정보 조회
			UserListAttDto getUserInfo();

			// 달력에 조회할 회원 출석 정보조회
			List<AttEvent> getAttInfo();
}
