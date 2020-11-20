package org.joongmae.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WishListVO implements Serializable{
	private int wishNo;
	private String id;
	private int sellNo;
	private String sellId;
}

