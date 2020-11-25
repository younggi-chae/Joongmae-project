package org.joongmae.service;


import java.util.List;

import org.joongmae.domain.BuyListWithPaging;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;
import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.DealListWithPaging;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.SellVO;
import org.joongmae.domain.WishAndSell;

import org.joongmae.domain.WishListVO;
import org.joongmae.domain.WishListWithPaging;


public interface MypageService {
	
	public List<BuyVO> getBuyList(Criteria cri);
	public int countBuy(Criteria cri);
	public BuyVO getBuyDetail(int buyNo);
	public int deleteBuy(int buyNo);
	public BuyListWithPaging getBuyListWithPaging(Criteria cri);
	public BuyListWithPaging dateSearchRange(Criteria cri);
	
	public List<SellVO> getSellList(Criteria cri);
	public int countSell(Criteria cri);
	public SellVO getSellDetail(int sellNo);
	public int deleteSell(int sellNo);
	public int deleteAllSell();
	
	public List<DealAndSell> getDealList(Criteria cri);
	public int countDeal(Criteria cri);
	public DealAndSell getDealDetail(int dealNo);
	public DealListWithPaging getDealListWithPaging(Criteria cri);
	public DealListWithPaging selectDeal(Criteria cri);	
	
	public List<WishAndSell> getWishList(Criteria cri);
	public int countWish(Criteria cri);
	public int addWishList(WishListVO wishList);
	public int deleteWishList(int sellNo);
	public int deleteWish(List<String> checkArr);
	public int deleteAllWish();
	public WishListWithPaging getWishListWithPaging(Criteria cri);
	
	public MemberVO getMemberDetail(String id);
	public boolean modifyMember(MemberVO member);
	public int deleteMember(String id);
	
	
	
}
