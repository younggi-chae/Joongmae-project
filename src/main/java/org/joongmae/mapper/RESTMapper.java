package org.joongmae.mapper;

import java.util.List;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.MemberAlarmSetVO;
import org.joongmae.domain.ReviewVO;

public interface RESTMapper {
	
	public int registerReview(ReviewVO review);
	
	public String showScore(String id);
	
	public int readAlarm(int alarmNo);
	
	public int setAlarm(MemberAlarmSetVO memberAlarmSet);
	
	public MemberAlarmSetVO getAlarmConfig(String id);
	
	public int getAlarmCount(String id);
	
	public List<AlarmVO> alarmList(String id);
}
