package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AlarmVO {
	private int alarmNo;
	private String buyId;
	private int buyNo;
	private String sellId;
	private int sellNo;
	private String status;
}
