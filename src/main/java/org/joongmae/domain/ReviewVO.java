package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReviewVO {
	private int dealNo;
	private String id;
	private String contents;
	private int score;
}
