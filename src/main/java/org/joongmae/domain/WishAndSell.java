package org.joongmae.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class WishAndSell implements Serializable {
	private int wishNo;	
	private int sellNo;
	private String sellId;
	private String itemName;
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private String type;
	private String region;
	private String itemcondition;
	private int price;
	private String picture;
	private String status;
}
