package org.joongmae.mapper;

import java.util.List;

import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;
import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.SelectDTO;
import org.joongmae.domain.SellVO;
import org.joongmae.domain.WishAndSell;
import org.joongmae.domain.WishListVO;


public interface MypageMapper {
	List<BuyVO> getBuyList(Criteria cri);
	int countBuy(Criteria cri);
	BuyVO getBuyDetail(int buyNo);
	List<BuyVO> dateSearchRange(Criteria cri);
	int dateCntRange(Criteria cri);
	
	List<SellVO> getSellList(Criteria cri);	
	int countSell(Criteria cri);
	SellVO getSellDetail(int sellNo);
	
	List<DealAndSell> getDealList(Criteria cri);
	int countDeal(Criteria cri);
	DealAndSell getDealDetail(int dealNo);	
	
	List<WishAndSell> getWishList(Criteria cri);
	int countWish(Criteria cri);
	int addWishList(WishListVO wishList);
	int deleteWishList(int sellNo);
	int deleteWish(SelectDTO wishNo);

	MemberVO getMemberDetail(String id);
	int modifyMember(MemberVO member);
	int deleteMember(String id);
	
	List<DealAndSell> completeDeal();
	List<DealAndSell> progressDeal();
	
}

