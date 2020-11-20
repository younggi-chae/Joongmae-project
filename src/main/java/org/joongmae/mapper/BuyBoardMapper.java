package org.joongmae.mapper;

import java.util.List;

import org.joongmae.domain.BuyCriteria;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.MemberVO;

public interface BuyBoardMapper {
	
	public int register(BuyVO vo);
	
	public List<BuyVO> list(BuyCriteria cri);
	
	public int buyTotalCount(BuyCriteria cri);
	
	public List<MemberVO> memberList();
	
	public BuyVO detail(int buyNo);
	
	public MemberVO memberDetail(String id);
	
	public int delete(int buyNo);
	
}
