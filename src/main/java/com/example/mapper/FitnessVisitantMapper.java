package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.FitnessVisitant;

@Mapper
public interface FitnessVisitantMapper {

	List<FitnessVisitant> getAllFitnessVisitantsByUserNo(int userNo);
}
