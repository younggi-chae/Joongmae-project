package org.joongmae.mapper;

import java.util.List;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.SellVO;

public interface SellMapper {
	
	public List<BuyVO> temp();
	
	public SellVO detail(int sellNo);
	
	public int register(SellVO sell);
	
	public int modify(SellVO sell);
	
	public int delete(int sellNo);
	
	public List<SellVO> list();
	
	public int registerAlarm(AlarmVO alarm);
	
	public int count();
	
	public int reRegister(int sellNo);
}
