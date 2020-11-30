package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReplyVO implements Serializable {	
	private int replyNo;
	private int dealNo;
	private String reply;
	private String id;
	private String replyDate;
	private String updateDate;
	
}
