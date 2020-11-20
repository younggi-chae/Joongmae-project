package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberAccountVO implements Serializable{

	private String accountNo;
	private String id;
	private String bankName;
	
	

}
