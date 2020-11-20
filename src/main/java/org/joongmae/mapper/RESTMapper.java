package org.joongmae.mapper;

import org.joongmae.domain.ReviewVO;

public interface RESTMapper {
	
	public int registerReview(ReviewVO review);
	
	public String showScore(String id);
	
	public int readAlarm(int alarmNo);
	
}
