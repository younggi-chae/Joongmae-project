package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PayVO {
	private int dealNo;
	private String payDate;
	private int price;
	private String sellAccount;
	private String status;
}
