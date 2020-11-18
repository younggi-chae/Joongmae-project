package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BuyVO {
	private int buyNo;
	private String id;
	private String title;
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private String type;
	private String region;
	private int minPrice;
	private int maxPrice;
	private String status;
	private String bigClassifier;
	private String mediumClassifier;
	
}
