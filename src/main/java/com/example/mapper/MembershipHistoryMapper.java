package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.MembershipHistory;

@Mapper
public interface MembershipHistoryMapper {

	List<MembershipHistory> getAllMembershipsByUserNo(int userNo);
}
