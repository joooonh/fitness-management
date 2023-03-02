package com.example.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ProgramCalendarDto;
import com.example.dto.ProgramScheduleDto;
import com.example.mapper.ProgramScheduleMapper;
import com.example.vo.Program;


@Service
@Transactional
public class ProgramScheduleService {

		@Autowired
		private ProgramScheduleMapper programScheduleMapper;

		
		public List<Program> getAllPrograms() {
			return programScheduleMapper.getAllPrograms();
		}
		
		public List<ProgramCalendarDto> getEvents(Map<String, Object> param) {
			return programScheduleMapper.getProgramEvents(param);

		}
		
		
	
}
