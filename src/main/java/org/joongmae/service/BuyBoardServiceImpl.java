package org.joongmae.service;

import java.util.List;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.BuyCriteria;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.MemberVO;
import org.joongmae.mapper.BuyBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BuyBoardServiceImpl implements BuyBoardService {
	
	@Autowired
	private BuyBoardMapper mapper;

	@Override
	public boolean register(BuyVO vo) {
		
		return mapper.register(vo) == 1;
	}

	@Override
	public List<BuyVO> list(BuyCriteria cri) {
		
		return mapper.list(cri);
	}

	@Override
	public int buyTotalCount(BuyCriteria cri) {
		
		return mapper.buyTotalCount(cri);
	}

	@Override
	public List<MemberVO> memberList() {
		
		return mapper.memberList();
	}

	@Override
	public BuyVO detail(int buyNo) {
		
		return mapper.detail(buyNo);
	}

	@Override
	public MemberVO memberDetail(String id) {
		
		return mapper.memberDetail(id);
	}

	@Override
	public boolean delete(int buyNo) {
		
		log.info(buyNo + " 구매글이 삭제되었습니다");
		
		return mapper.delete(buyNo) == 1;
	}
	
	@Transactional
	@Override
	public void reRegister(BuyVO buy, int buyNo) {
		
		mapper.delete(buyNo);
		mapper.register(buy);
		
	}

	@Override
	public List<AlarmVO> alarmList(String id) {
		
		return mapper.alarmList(id);
	}

}
