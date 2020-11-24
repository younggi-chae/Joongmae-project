package org.joongmae.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class BuyListWithPaging {
	
	private int buyCnt;
	private List<BuyVO> list;
}
