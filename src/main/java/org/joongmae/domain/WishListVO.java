package org.joongmae.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class WishListVO {
	private int wishNo;
	private String id;
	private int sellNo;
	private String sellId;
}
