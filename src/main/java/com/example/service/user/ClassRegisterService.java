package com.example.service.user;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.ScheduleCheckDto;
import com.example.exception.ApplicationException;
import com.example.mapper.ClassRegisterMapper;
import com.example.mapper.ProgramMapper;
import com.example.mapper.UserMapper;
import com.example.vo.Program;
import com.example.vo.ProgramDay;
import com.example.vo.User;
import com.sun.jdi.VirtualMachine;
import com.sun.jdi.event.Event;
import com.sun.jdi.request.EventRequest;

@Service
@Transactional
public class ClassRegisterService {
	
	@Autowired
	ClassRegisterMapper classRegisterMapper;
	@Autowired
	ProgramMapper programMapper;
	@Autowired
	UserMapper userMapper;

	// 모든 프로그램 조회 
	public List<Program> getAllPrograms(){
		return classRegisterMapper.getAllPrograms();
	}
	
	// 프로그램 번호로 프로그램 조회
	public Program getProgramByProgNo(int programNo) {
		return programMapper.getProgramByProgramNo(programNo);
	}
	
	// 프로그램 신청
	public void registerClass(String userId, Map<String, Object> param) {
		
		User user = userMapper.getUserById(userId);
		Program program = programMapper.getProgramByProgramNo((int) param.get("progNo"));
		if(user == null) {
			throw new ApplicationException("[" + userId + "] 존재하지 않는 아이디입니다.");
		}
		if(program == null) {
			throw new ApplicationException("[" + program + "] 존재하지 않는 프로그램입니다.");
		}
		int userNo = user.getNo();
		
		// 수업신청(회원번호, 프로그램 번호, 프로그램 가격), 회원권신청(회원번호, 시작날짜, 종료날짜, 기간, 가격)
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("programNo", param.get("progNo"));
		map.put("programPrice", program.getPrice());
		map.put("memStartDate", param.get("memStartDate"));
		map.put("memEndDate", param.get("memEndDate"));
		map.put("memPeriod", param.get("memPeriod"));
		map.put("memPrice", param.get("memPrice"));
		
		classRegisterMapper.insertClassRegistration(map);
		classRegisterMapper.insertMembership(map);
		
	}
	
	// 달력에 표시될 프로그램 일정 조회
	public List<ScheduleCheckDto> getAllSchedules(String startDate, String endDate){
		
		// 프로그램마다 달력에 표시될 내용으로 구성된 객체를 담을 리스트
		List<ScheduleCheckDto> schedules = new ArrayList<>();
		// 지정된 기간에 해당하는 전체 프로그램
		List<Program> programs = classRegisterMapper.getProgramSchedules(startDate, endDate);
		
		for(Program program : programs) {
			// 프로그램별 요일 리스트 조회
			List<ProgramDay> dayNames = classRegisterMapper.getAllProgramDays(program.getNo());
			// getEvents 메소드 실행해서 시작날짜, 종료날짜, 프로그램, 요일을 이용해 schedulecheckdto 리스트 생성
			List<ScheduleCheckDto> scheduleEvents = getEvents(startDate, endDate, program, dayNames);
			// 모든 수업에 대해 리스트를 담아서 전체 리스트 반환
			schedules.addAll(scheduleEvents);
		}
		return schedules;
	}
	// 지정된 기간, 요일에 해당하는 schedulecheckdto 리스트를 반환하는 메소드  
	public List<ScheduleCheckDto> getEvents(String startDateStr, String endDateStr, Program program, List<ProgramDay> dayNames){
		// 날짜를 문자열로 변환하는 데 사용할 simpleDateFormat 지정 
		SimpleDateFormat f1 = new SimpleDateFormat("d일 EEE");
		SimpleDateFormat f2 = new SimpleDateFormat("E");
		
		// 문자열로 받은 startDate, endDate를 LocalDate 객체로 변환(날짜 정보를 쉽게 다루는 클래스)
		LocalDate startDate = LocalDate.parse(startDateStr);
		LocalDate endDate = LocalDate.parse(endDateStr).plusDays(1);	// 1을 더해야 마지막 날짜까지 포함
		// 반환할 schedulecheckdto 리스트 만들기 
		List<ScheduleCheckDto> scheduleEvents = new ArrayList<>();
		// 시작일부터 종료일 전까지 반복 
		while(startDate.isBefore(endDate)) {
			// startDate에 해당하는 요일을 문자열로 반환
			String dayname = startDate.format(DateTimeFormatter.ofPattern("EEE"));
			
			if(dayNames.contains(dayname)) {
				// 해당 요일이 해당 프로그램의 요일에 포함되면 Schedule 객체 생성 -> 리스트에 추가
				ScheduleCheckDto schedule = new ScheduleCheckDto();
				// schedule 객체의 시작일, 종료일, 제목 설정
				schedule.setStart(toDate(startDate));
				schedule.setEnd(toDate(endDate));
				schedule.setTitle(program.getName());
				
				scheduleEvents.add(schedule);
			}
			// 시작일을 하루씩 늘려가면서 반복 
			startDate = startDate.plusDays(1);
		}
		return scheduleEvents;
	}
	// LocalDate 객체를 Date 객체로 변환
	private Date toDate(LocalDate startDate) {
		ZoneId defaultZoneId = ZoneId.systemDefault();
		return Date.from(startDate.atStartOfDay(defaultZoneId).toInstant());
	}

	
}
