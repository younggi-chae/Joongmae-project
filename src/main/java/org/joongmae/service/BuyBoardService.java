package org.joongmae.service;

import java.util.List;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.BuyCriteria;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.SellVO;

public interface BuyBoardService {
	
	public boolean register(BuyVO vo);
	
	public List<BuyVO> list(BuyCriteria cri);
	
	public int buyTotalCount(BuyCriteria cri);
	
	public List<MemberVO> memberList();
	
	public BuyVO detail(int buyNo);
	
	public MemberVO memberDetail(String id);
	
	public boolean delete(int buyNo);
	
	public void reRegister(BuyVO buy, int buyNo);
	
	public List<AlarmVO> alarmList(String id);
	
	public List<SellVO> sellList(String id);
	
	public SellVO sellDetail(int sellNo);
	
	public boolean registerAlarm(AlarmVO vo);
	
	public int registerAlarmAuto(BuyVO buy);
}
