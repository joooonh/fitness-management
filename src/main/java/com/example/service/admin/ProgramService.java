package com.example.service.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ProgramDayDto;
import com.example.dto.ProgramDto;
import com.example.exception.ApplicationException;
import com.example.mapper.ProgramMapper;
import com.example.utils.Pagination;
import com.example.vo.Program;
import com.example.vo.ProgramCategory;
import com.example.vo.ProgramDay;
import com.example.vo.User;
import com.example.web.request.ProgramForm;

@Service
@Transactional
public class ProgramService {

	@Autowired
	ProgramMapper programMapper;
	
	// 프로그램 목록 조회(페이징)
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
		
		List<ProgramDto> programs = programMapper.getAllPrograms(param);
		
		for (ProgramDto programDto : programs) {
			Program program = programMapper.getProgramByProgramNo(programDto.getNo());
			// 프로그램 정원과 신청인원이 같으면 마감처리한다.
			if (program.getQuota() == program.getRequestCount()) {
				program.setStatus("마감");
				programMapper.updateProgram(program);
			}
			// 프로그램 시작일과 종료일, 오늘날짜를 비교한다.
			Date today = new Date();
			Date startDate = program.getStartDate();
			Date endDate = program.getEndDate();
			boolean startCompare = today.after(startDate);
			boolean endCompare = today.after(endDate);
			// 프로그램 시작일이 오늘날짜가 지나면 진행중으로 바뀐다.
			if (startCompare) {
				program.setStatus("진행중");
				programMapper.updateProgram(program);
			}
			// 프로그램 종료일이 지나면 마감처리한다.
			if (endCompare) {
				program.setStatus("마감");
				programMapper.updateProgram(program);
			}
		}
		
		// controller에 전달해줄 Map<String, Object> 객체 생성
		Map<String, Object> result = new HashMap<>();
		
		result.put("programs", programs);
		result.put("pagination", pagination);
		
		return result;
	}
	
	// 모든 프로그램 목록 조회
	public List<ProgramDto> getAllProgramList() {
		List<ProgramDto> programs = programMapper.getAllProgramList();
		
		for (ProgramDto programDto : programs) {
			Program program = programMapper.getProgramByProgramNo(programDto.getNo());
			// 프로그램 정원과 신청인원이 같으면 마감처리한다.
			if (program.getQuota() == program.getRequestCount()) {
				program.setStatus("마감");
				programMapper.updateProgram(program);
			}
			// 프로그램 시작일과 종료일, 오늘날짜를 비교한다.
			Date today = new Date();
			Date startDate = program.getStartDate();
			Date endDate = program.getEndDate();
			boolean startCompare = today.after(startDate);
			boolean endCompare = today.after(endDate);
			// 프로그램 시작일이 오늘날짜가 지나면 진행중으로 바뀐다.
			if (startCompare) {
				program.setStatus("진행중");
				programMapper.updateProgram(program);
			}
			// 프로그램 종료일이 지나면 마감처리한다.
			if (endCompare) {
				program.setStatus("마감");
				programMapper.updateProgram(program);
			}
		}
		return programs;
	}
	
	// 프로그램 상세 정보
	public ProgramDto getProgramDetail(int programNo) {
		// 프로그램번호로 프로그램 정보 조회
		ProgramDto programDto = programMapper.getProgramDetail(programNo);
		if (programDto == null) {
			throw new ApplicationException(programNo+"에 해당하는 프로그램 정보가 없습니다.");
		}
		return programDto;
	}
	
	// 프로그램 신청자 목록
	public List<User> getProgramUser(int programNo) {
		return programMapper.getUsersByProgramNo(programNo);
	}
	
	// 프로그램 분류 목록
	public List<ProgramCategory> getProgramCategory() {
		return programMapper.getProgramCategory();
	}

	// 프로그램 카테고리 수정
	public void updateCategory(int no, String name) {
		ProgramCategory category =programMapper.getCategoryByNo(no);
		category.setName(name);
		programMapper.updateCategory(category);
	}
	
	// 프로그램 카테고리 삭제
	public void deleteCategory(int no, String name) {
		ProgramCategory category =programMapper.getCategoryByNo(no);
		programMapper.deleteCategory(category);
	}
	// 프로그램 카테고리 등록
	public void insertCategory(String name) {
		programMapper.insertCategory(name);
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
		if (program == null) {
			throw new ApplicationException(form.getNo()+"에 해당하는 프로그램 정보가 없습니다.");
		}
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
	
	// 프로그램 선택요일 조회
	public List<ProgramDayDto> getDayStatusByProgramNo(int programNo) {
		return programMapper.getDaysByProgramNo(programNo);
	}
	
	// 프로그램 등록 요일 조회
	public List<ProgramDayDto> getDaysByProgramNoStatusY(int programNo) {
		return programMapper.getDaysByProgramNoStatusY(programNo);
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
