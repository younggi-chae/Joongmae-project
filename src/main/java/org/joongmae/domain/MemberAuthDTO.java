package org.joongmae.domain;

import lombok.Data;

@Data
public class MemberAuthDTO {

	private String id;
	private String password;
	private String auth;
	private int enabled;
}
