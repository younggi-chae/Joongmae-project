package org.joongmae.domain;

import lombok.Data;

@Data
public class BuyDTO {
	private int buyNo;
	private String id;
	private String title;
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private String type;
	private String region;
	private String minPrice;
	private String maxPrice;
	private String status;
	private String bigClassifier;
	private String mediumClassifier;
	
}
