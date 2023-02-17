package com.example.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ProgramDto;
import com.example.mapper.ProgramMapper;
import com.example.vo.Program;

@Service
@Transactional
public class Programservice {

	@Autowired
	private ProgramMapper programMapper;
	
	public ProgramDto getProgramByProgramName(String programName) {
		ProgramDto programDto = programMapper.getProgramByProgramName(programName);
		
		return programDto;
	}
	
	public List<Program> getAllPrograms() {
		return programMapper.getAllPrograms();
	}
}
