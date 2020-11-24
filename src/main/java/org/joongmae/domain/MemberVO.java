package org.joongmae.domain;


import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO implements Serializable{
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
	
	private boolean enabled;
	private List<AuthVO> authList;
	
	
}

