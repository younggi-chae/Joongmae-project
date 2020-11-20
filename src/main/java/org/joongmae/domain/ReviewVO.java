package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO implements Serializable{
	private int dealNo;
	private String id;
	private String contents;
	private int score;
}
