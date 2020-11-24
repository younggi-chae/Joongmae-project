package org.joongmae.service;

import java.util.List;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.MemberAlarmSetVO;
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

	@Override
	public int setAlarm(MemberAlarmSetVO memberAlarmSet) {
		
		return mapper.setAlarm(memberAlarmSet);
	}

	@Override
	public MemberAlarmSetVO getAlarmConfig(String id) {
		
		return mapper.getAlarmConfig(id);
	}

	@Override
	public int getAlarmCount(String id) {
		
		return mapper.getAlarmCount(id);
	}

	@Override
	public List<AlarmVO> alarmList(String id) {
		
		return mapper.alarmList(id);
	}

}
