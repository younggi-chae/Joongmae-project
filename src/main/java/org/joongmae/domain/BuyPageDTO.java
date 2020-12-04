package org.joongmae.domain;

import lombok.Data;

@Data
public class BuyPageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int total;
	private BuyCriteria cri;
	
	
	public BuyPageDTO(int total, BuyCriteria cri) {
		this.total = total;
		this.cri = cri;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 5.0)) * 5;
		
		this.startPage = this.endPage - 4;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage){
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
		
	}
	
	
	
}
