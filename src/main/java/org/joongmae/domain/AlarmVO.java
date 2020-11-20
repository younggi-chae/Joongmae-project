package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AlarmVO implements Serializable{
	private int alarmNo;
	private String buyId;
	private int buyNo;
	private String sellId;
	private int sellNo;
	private String status;
}
