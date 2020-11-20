package org.joongmae.service;

import java.util.List;

import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;

import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.SellVO;
import org.joongmae.domain.WishAndSell;
import org.joongmae.domain.WishListVO;
import org.joongmae.mapper.MypageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MypageServiceImpl implements MypageService {

	@Setter(onMethod_ = @Autowired)
	private MypageMapper mapper;
	
	@Override
	public List<BuyVO> getBuyList(Criteria cri) {		
		return mapper.getBuyList(cri);
	}

	@Override
	public int countBuy(Criteria cri) {
		return mapper.countBuy(cri);
	}
	
	@Override
	public BuyVO getBuyDetail(int buyNo) {		
		return mapper.getBuyDetail(buyNo);
	}

	@Override
	public List<SellVO> getSellList(Criteria cri) {		
		return mapper.getSellList(cri);
	}

	@Override
	public int countSell(Criteria cri) {		
		return mapper.countSell(cri);
	}
	
	@Override
	public SellVO getSellDetail(int sellNo) {		
		return mapper.getSellDetail(sellNo);
	}

	@Override
	public List<DealAndSell> getDealList(Criteria cri) {				
		return mapper.getDealList(cri);
	}

	@Override
	public int countDeal(Criteria cri) {		
		return mapper.countDeal(cri);
	}
	
	@Override
	public DealAndSell getDealDetail(int dealNo) {		
		return mapper.getDealDetail(dealNo);
	}

	@Override
	public MemberVO getMemberDetail(String id) {		
		return mapper.getMemberDetail(id);
	}

	@Override
	public boolean modifyMember(MemberVO member) {	
		System.out.println(member);
		return mapper.modifyMember(member) == 1;
	}
	
	@Override
	public int deleteMember(String id) {		
		return mapper.deleteMember(id);
	}	

	@Override
	public List<WishAndSell> getWishList(Criteria cri) {		
		return mapper.getWishList(cri);
	}

	@Override
	public int countWish(Criteria cri) {		
		return mapper.countWish(cri);
	}

	@Override
	public int addWishList(WishListVO wishList) {		
		return mapper.addWishList(wishList);
	}	
	
	@Override
	public int deleteWishList(int sellNo) {		
		return mapper.deleteWishList(sellNo);
	}

	@Override
	public List<DealAndSell> completeDeal() {		
		return mapper.completeDeal();
	}

	@Override
	public List<DealAndSell> progressDeal() {		
		return mapper.progressDeal();
	}
	
}
