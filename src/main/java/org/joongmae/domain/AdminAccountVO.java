package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminAccountVO implements Serializable{
	private int actionNo;
	private int dealNo;
	private String accountNo;
	private String isDeposit;
	private String isWithdraw;
	private String depositDate;
	private String withdrawDate;
	private int balance;
}
