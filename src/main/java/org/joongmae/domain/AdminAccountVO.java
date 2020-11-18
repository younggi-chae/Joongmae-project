package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AdminAccountVO {
	private int actionNo;
	private int dealNo;
	private String accountNo;
	private String isDeposit;
	private String isWithdraw;
	private String depositDate;
	private String withdrawDate;
	private int balance;
}
