package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PayVO implements Serializable{
	private int dealNo;
	private String payDate;
	private int price;
	private String sellAccount;
	private String status;
}
