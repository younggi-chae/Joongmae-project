package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BuyCriteria {
	
	private int pageNum;
	private int amount;
	
	private String bigClassifier;
	private String mediumClassifier;
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private int minPrice;
	private int maxPrice;
	
	private String highPrice;
	private String lowPrice;
	
	public BuyCriteria(){
		this(1, 3);
	}

	public BuyCriteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	
	
}
