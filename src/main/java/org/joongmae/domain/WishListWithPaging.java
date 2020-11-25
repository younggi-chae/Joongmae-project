package org.joongmae.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class WishListWithPaging {

	private int wishCnt;
	private List<WishAndSell> list;
}
