package org.joongmae.domain;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MemberVO {
	private String id;
	private String password;
	private String name;
	private String phoneNo;
	private String email;
	private String sex;
	private String address;
	private String picture;
	private String introduction;
	private double avgScore;
	private String isMember;
	private String isAlarm;
	private String alarmStartTime;
	private String alarmEndTime;
	
	
}
