package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.ClassRegHistoryDto;
import com.example.dto.ConsultingHistoryDto;
import com.example.vo.MembershipHistory;
import com.example.vo.ProgramDay;

@Mapper
public interface UserMypageMapper {

	// 회원권 조회
	List<MembershipHistory> getAllMembershipsByUserNo(int userNo);
	// 수업 예약 조회
	List<ClassRegHistoryDto> getAllClassRegHistoriesDtoByUserNo(int userNo);
	// 수업 번호에 해당하는 요일 조회 
	List<ProgramDay> getProgramDayByProgramNo(int programNo);
	// 상담 예약 조회
	List<ConsultingHistoryDto> getAllConsultingHistoryDtosByUserNo(int userNo);
}
