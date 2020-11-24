package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BuyVO implements Serializable{
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
	private String regDate;
	
}

