package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberAlarmSetVO {
	private String id;
	private String isAlarm;
	private String alarmStartTime;
	private String alarmEndTime;
}
