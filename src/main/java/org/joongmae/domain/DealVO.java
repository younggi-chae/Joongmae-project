package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DealVO {
	private int dealNo;
	private String buyId;
	private int buyNo;
	private String sellId;
	private int sellNo;
	private int price;
	private String regDate;
	private String status;
}
