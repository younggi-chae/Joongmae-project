package org.joongmae.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class DealAndSell implements Serializable {
	private int dealNo;
	private String buyId;	
	private String sellId;	
	private String itemName;
	private String type;
	private String region;
	private String itemCondition;
	private String bigClassifier;
	private String mediumClassifier; 
	private String picture;
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private int price;	
	private String regDate;
	private String status;	
	
}
