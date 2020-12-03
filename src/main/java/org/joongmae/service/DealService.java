package org.joongmae.service;

import java.util.List;

import org.joongmae.domain.DealVO;
import org.joongmae.domain.PayVO;
import org.joongmae.domain.SellVO;

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
