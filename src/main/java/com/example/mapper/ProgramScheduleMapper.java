package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ProgramCalendarDto;
import com.example.dto.ProgramScheduleDto;
import com.example.vo.Program;

@Mapper
public interface ProgramScheduleMapper {


	List<Program> getAllPrograms(); 
	
	List<ProgramCalendarDto> getProgramEvents(Map<String, Object> param);
	ProgramCalendarDto getProgramEventsByNo(int programNo);
	List<String> getAllProgramDays(int progNo);
}
