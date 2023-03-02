package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.AttEvent;
import com.example.dto.UserAttDetailDto;
import com.example.dto.UserListAttDto;
import com.example.mapper.UserAttCalendarMapper;
import com.example.mapper.UserAttMapper;
import com.example.utils.Pagination;
import com.example.vo.FitnessProgramCategory;
import com.example.vo.User;

@Service
@Transactional
public class UserAttCalendarService {
	
	@Autowired
	UserAttCalendarMapper userAttCalendarMapper;
	
	@Autowired
	UserAttMapper userAttMapper;
	
	//출석리스트 조회
		public Map<String,Object> getUserList(int page,String opt,String keyword, String programInfo) {
			Map<String,Object> param = new HashMap<String,Object>();
			if (!programInfo.isBlank()) {
				param.put("programInfo", programInfo);
				if (!keyword.isBlank()) {
					param.put("keyword", keyword);			
				}
			}
			if (!opt.isBlank() && !keyword.isBlank()) {
				param.put("opt", opt);
				param.put("keyword", keyword);			
			}

			int totalRows = userAttCalendarMapper.getTotalRows(param);
			Pagination pagination = new Pagination(page,totalRows);
			
			param.put("begin", pagination.getBegin());
			param.put("end", pagination.getEnd());
			
			List<UserListAttDto> users = userAttCalendarMapper.getUserList(param);
			
			Map<String,Object> result = new HashMap<>();
			result.put("userAtts", users );
			result.put("pagination", pagination);
			
			return result;
		}
		
		// 프로그램 프로그램명 조회
		public List<FitnessProgramCategory> getPrograms()	{
			
			return userAttCalendarMapper.getPrograms();
		}
		
		// 달력 조회
		public List<AttEvent> getEvents(Map<String, Object> param) {
			
			
			return userAttCalendarMapper.getAttEvents(param);
		}

		// 상세정보 조회
		public UserAttDetailDto getUserDetail(String userNo) {
			UserListAttDto attDto = userAttCalendarMapper.getUserByNo(userNo);
			
			UserAttDetailDto detailDto = new UserAttDetailDto();
			BeanUtils.copyProperties(attDto, detailDto);
			
			return detailDto;
			
		}
		
		// 달력에 조회할 회원 정보 조회
		public UserListAttDto getUserInfo() {
			
			return userAttCalendarMapper.getUserInfo();
		}

		public List<AttEvent> getAttInfo() {

			return userAttCalendarMapper.getAttInfo();
		}
		
		
}
