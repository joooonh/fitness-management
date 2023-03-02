package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("MembershipDto")
@Getter
@Setter
public class MembershipDto {

	// 회원권 등록 정보
	private int membershipNo;
	private Date startDate;
	private Date endDate;
	private int period;
	private Date completedDate;
	// 이용자 정보
	private int userNo;
	private String name;
	private String tel;
}
