package org.joongmae.service;

import org.joongmae.domain.ReviewVO;
import org.joongmae.mapper.RESTMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class RESTServiceImpl implements RESTService {

	@Setter(onMethod_ = @Autowired)
	private RESTMapper mapper;
	
	@Override
	public int registerReview(ReviewVO review) {
		
		return mapper.registerReview(review);
		
	}

	@Override
	public String showScore(String id) {
		
		return mapper.showScore(id);
	}

	@Override
	public int readAlarm(int alarmNo) {
		
		return mapper.readAlarm(alarmNo);
	}

}
