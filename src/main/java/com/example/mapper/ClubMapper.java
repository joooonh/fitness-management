package com.example.mapper;


import org.apache.ibatis.annotations.Mapper;

import com.example.vo.Club;


@Mapper
public interface ClubMapper {

	// 피트니스 매장 정보
	Club getClub();
	// 매장번호로 매장 정보 조회
	Club getClubByNo(int no);
	// 매장정보 수정
	void updateClub(Club club);
}
