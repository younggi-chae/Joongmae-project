package org.joongmae.service;

import org.joongmae.domain.ReviewVO;

public interface RESTService {
	
	public int registerReview(ReviewVO review);
	
	public String showScore(String id);
	
	public int readAlarm(int alarmNo);
	
}
