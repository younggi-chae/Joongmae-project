package org.joongmae.service;

import org.joongmae.domain.DealVO;
import org.joongmae.domain.PayVO;
import org.joongmae.mapper.DealMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class DealServiceImpl implements DealService {

	@Setter(onMethod_ = @Autowired)
	private DealMapper mapper;
	
	@Override
	public int registerDeal(DealVO deal) {
		
		return mapper.registerDeal(deal);
	}

	@Override
	public int cancel(int dealNo) {
		
		return mapper.cancel(dealNo);
	}

	@Override
	public int send(int dealNo) {
		
		return mapper.send(dealNo);
	}

	@Override
	public int done(int dealNo) {
		mapper.payDone(dealNo);
		return mapper.done(dealNo);
	}

	@Override
	public int registerPay(PayVO pay) {
		pay.setStatus("입금");
		
		return mapper.registerPay(pay);
	}

	@Override
	public int refund(int dealNo) {
		mapper.done(dealNo);
		return mapper.refund(dealNo);
	}

	@Override
	public PayVO detailDeal(int dealNo) {
		
		return mapper.detailDeal(dealNo);
	}

	@Override
	public int registerPayDone(int dealNo) {
		
		return mapper.registerPayDone(dealNo);
	}

}
