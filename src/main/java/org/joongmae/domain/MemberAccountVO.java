package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MemberAccountVO {
	private String accountNo;
	private String id;
	private String bankName;
}
