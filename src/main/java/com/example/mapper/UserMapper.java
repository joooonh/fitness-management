package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.UserListAttDto;
import com.example.vo.FitnessProgramCategory;

@Mapper
public interface UserMapper {
		
	int getTotalRows();
	List<UserListAttDto> getUserList(Map<String,Object>param);
	
	List<FitnessProgramCategory> getPrograms();
}
