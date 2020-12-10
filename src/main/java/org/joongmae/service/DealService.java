package org.joongmae.service;

import org.joongmae.domain.DealVO;
import org.joongmae.domain.PayVO;

public interface DealService {

	public int registerDeal(DealVO deal);
	
	public int cancel(int dealNo);
	
	public int send(int dealNo);
	
	public int done(int dealNo);
	
	public int registerPay(PayVO pay);
	
	public int refund(int dealNo);
	
	public PayVO detailDeal(int dealNo);
	
	public int registerPayDone(int dealNo);
}
