package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.ClassRegistrationHistory;

@Mapper
public interface ClassRegistrationHistoryMapper {

	List<ClassRegistrationHistory> getAllClassRegistrationHistoryByUserNo(int userNo);
}
