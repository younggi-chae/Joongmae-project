package org.joongmae.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;
import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.ReplyVO;
import org.joongmae.domain.SellVO;
import org.joongmae.domain.WishAndSell;
import org.joongmae.domain.WishListVO;


public interface MypageMapper {
	List<BuyVO> getBuyList(Criteria cri);
	int countBuy(Criteria cri);
	BuyVO getBuyDetail(int buyNo);
	List<BuyVO> dateSearchRange(Criteria cri);
	int dateCntRange(Criteria cri);
	int deleteBuy(int buyNo);
	int buyCnt(String id);
	
	List<SellVO> getSellList(Criteria cri);	
	int countSell(Criteria cri);
	SellVO getSellDetail(int sellNo);
	int deleteSell(int sellNo);
	int deleteAllSell();
	int sellCnt(String id);
	
	List<DealAndSell> getDealList(Criteria cri);
	int countDeal(Criteria cri);
	DealAndSell getDealDetail(int dealNo);
	List<DealAndSell> selectDeal(Criteria cri);
	int countSelectDeal(Criteria cri);
	int deleteDeal(int dealNo);
	int completeCnt(Criteria cri);
	int progressCnt(Criteria cri); 
	
	List<WishAndSell> getWishList(Criteria cri);
	int countWish(Criteria cri);
	int addWishList(WishListVO wishList);
	int deleteWishList(int sellNo);
	int deleteWish(List<String> checkArr);
	int deleteAllWish();

	MemberVO getMemberDetail(String id);
	int modifyMember(MemberVO member);
	int deleteMember(String id);
	int deleteUser(String id);
	
	int replyInsert(ReplyVO reply);
	List<ReplyVO> replyList(int dealNo);	
	int replyDelete(int replyNo);	
}

