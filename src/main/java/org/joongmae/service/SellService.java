package org.joongmae.service;

import java.util.List;

import org.joongmae.domain.SellVO;

public interface SellService {
	
	public SellVO detail(int sellNo);
	
	public int register(SellVO sell);
	
	public int modify(SellVO sell);
	
	public int delete(int sellNo);
	
	public List<SellVO> list();
	
	public int registerAlarm(SellVO sell);
	
	public int reRegister(int sellNo);
}
