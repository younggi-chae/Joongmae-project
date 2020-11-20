package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DealVO implements Serializable{
	private int dealNo;
	private String buyId;
	private int buyNo;
	private String sellId;
	private int sellNo;
	private int price;
	private String regDate;
	private String status;
}
