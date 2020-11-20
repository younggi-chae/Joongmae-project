package org.joongmae.service;


import java.util.List;

import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;
import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.MemberVO;

import org.joongmae.domain.SellVO;
import org.joongmae.domain.WishAndSell;

import org.joongmae.domain.WishListVO;

public interface MypageService {
	
	public List<BuyVO> getBuyList(Criteria cri);
	public int countBuy(Criteria cri);
	public BuyVO getBuyDetail(int buyNo);
	
	public List<SellVO> getSellList(Criteria cri);
	public int countSell(Criteria cri);
	public SellVO getSellDetail(int sellNo);
	
	public List<DealAndSell> getDealList(Criteria cri);
	public int countDeal(Criteria cri);
	public DealAndSell getDealDetail(int dealNo);
	
	public List<WishAndSell> getWishList(Criteria cri);
	public int countWish(Criteria cri);
	public int addWishList(WishListVO wishList);
	public int deleteWishList(int sellNo);	
	
	public MemberVO getMemberDetail(String id);
	public boolean modifyMember(MemberVO member);
	public int deleteMember(String id);
	
	public List<DealAndSell> completeDeal();
	public List<DealAndSell> progressDeal();
}
