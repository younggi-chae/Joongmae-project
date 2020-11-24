package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SellVO implements Serializable{
	private int sellNo;
	private String id;
	private String itemName;
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private String type;
	private String region;
	private String itemCondition;
	private int price;
	private String picture;
	private String status;
	private String MediumClassifier;
	private String BigClassifier;
	private String regDate;
}

