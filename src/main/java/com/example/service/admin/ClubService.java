package com.example.service.admin;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.exception.ApplicationException;
import com.example.mapper.ClubMapper;
import com.example.vo.Club;
import com.example.web.request.ClubModifyForm;

@Service
@Transactional
public class ClubService {
	
	@Autowired
	ClubMapper clubMapper;

	public Club getClub() {
		return clubMapper.getClub();
	}

	public void updateClub(ClubModifyForm form) {
		Club club = clubMapper.getClubByNo(form.getNo());
		
		if (club == null) {
			throw new ApplicationException("[ " + form.getNo() + "] 해당하는 매장이 없습니다. ");
		}
		
		BeanUtils.copyProperties(form, club);
		
		club.setWeekdaysOpenHours(form.getWeekdaysStartTime()+"~"+form.getWeekdaysEndTime());
		club.setWeekendsOpenHours(form.getWeekendsStartTime()+"~"+form.getWeekendsEndTime());
		
		clubMapper.updateClub(club);
		
	}
}
