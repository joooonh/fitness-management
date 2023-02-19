package com.example.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ProgramDto;
import com.example.dto.ProgramScheduleDto;
import com.example.mapper.ProgramMapper;
import com.example.mapper.ProgramScheduleMapper;
import com.example.vo.Program;


@Service
@Transactional
public class ProgramScheduleService {

		@Autowired
		private ProgramScheduleMapper programScheduleMapper;
		
		public ProgramScheduleDto getProgramByProgramName(String programName) {
			ProgramScheduleDto programScheduleDto = programScheduleMapper.getProgramByProgramName(programName);
			
			return programScheduleDto;
		}
		
		public List<Program> getAllPrograms() {
			return programScheduleMapper.getAllPrograms();
		}
	
}
