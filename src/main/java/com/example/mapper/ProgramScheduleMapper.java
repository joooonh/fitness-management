package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ProgramDto;
import com.example.dto.ProgramScheduleDto;
import com.example.vo.Program;

@Mapper
public interface ProgramScheduleMapper {

	ProgramScheduleDto getProgramByProgramName(String programName);
	List<Program> getAllPrograms(); 
	
}
