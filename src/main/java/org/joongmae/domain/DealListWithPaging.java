package org.joongmae.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class DealListWithPaging {
	
	private int dealCnt;
	private List<DealAndSell> list;	
}
