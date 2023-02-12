package com.example.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dto.ProgramDto;
import com.example.mapper.ProgramMapper;
import com.example.utils.Pagination;
import com.example.vo.Program;
import com.example.vo.ProgramCategory;
import com.example.vo.ProgramDay;
import com.example.vo.User;
import com.example.web.request.ProgramForm;

@Service
public class ProgramService {

	@Autowired
	ProgramMapper programMapper;
	
	public Map<String, Object> getAllgrograms(int page, String sort, String keyword) {
		// 검색조건에 해당하는 프로그램 목록 갯수
		Map<String, Object> rows = new HashMap<>();
		rows.put("sort", sort);
		rows.put("keyword", keyword);
		
		// 총 프로그램 갯수 조회
		int totalRows = programMapper.getTotalRows(rows);
		Pagination pagination = new Pagination(page, totalRows);
		
		// 페이징처리에 필요한 Map<String, Object>객체 생성
		Map<String, Object> param = new HashMap<>();
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		param.put("sort", sort);
		param.put("keyword", keyword);
		
		List<Program> programs = programMapper.getAllPrograms(param);
		
		// controller에 전달해줄 Map<String, Object> 객체 생성
		Map<String, Object> result = new HashMap<>();
		
		result.put("programs", programs);
		result.put("pagination", pagination);
		
		return result;
	}
	
	public ProgramDto getProgramDetail(int programNo) {
		// 프로그램번호로 프로그램 정보 조회
		ProgramDto programDetail = programMapper.getProgramDetail(programNo);
		// 프로그램번호로 프로그램 진행 요일 조회
		List<ProgramDay> days = programMapper.getProgramDayByProgramNo(programNo);
		
		programDetail.setDays(days);
		
		return programDetail;
	}
	
	// 프로그램 신청자 목록
	public List<User> getProgramUser(int programNo) {
		return programMapper.getUsersByProgramNo(programNo);
	}
	
	// 프로그램 분류 목록
	public List<ProgramCategory> getProgramCategory() {
		return programMapper.getProgramCategory();
	}
	
	// 프로그램 등록
	public void insertProgram(ProgramForm form) {
		Program program = new Program();
		ProgramDay programDay = new ProgramDay();
		BeanUtils.copyProperties(form, program);
		BeanUtils.copyProperties(form, programDay);
		
		// "," 를 기준으로 프로그램 진행 요일을 잘라서 days에 담는다.
		String[] days = programDay.getDay().split(",");
		
		programMapper.insertProgram(program); 
		
		for (String day : days) {
			programDay.setProgramNo(program.getNo());
			programDay.setDay(day);
			programMapper.insertProgramDays(programDay);
		}
	}
	
	// 프로그램 수정
	public void updateProgram(ProgramForm form) {
		// 프로그램 정보 조회
		Program program = programMapper.getProgramByProgramNo(form.getNo());
		BeanUtils.copyProperties(form, program);
		
		programMapper.deleteProgramDays(form.getNo());
		
		programMapper.updateProgram(program);

		// "," 를 기준으로 프로그램 진행 요일을 잘라서 days에 담는다.
		String[] days = form.getDay().split(",");
		
		ProgramDay programDay = new ProgramDay();
		
		for (String day : days) {
			programDay.setProgramNo(form.getNo());
			programDay.setDay(day);
			programMapper.insertProgramDays(programDay);
		}
	}
	
	// 프로그램 삭제
	public void deleteProgram(String programNo) {
		
		// "," 를 기준으로 프로그램 번호를 잘라서 programNos에 담는다.
		String[] programNos = programNo.split(",");
		
		for(String value : programNos) {
			int no = Integer.parseInt(value);
			programMapper.deleteProgramDays(no);
			programMapper.deleteProgram(no);
		}
	}
}
