package org.joongmae.service;

import java.util.List;

import org.joongmae.domain.BuyListWithPaging;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;

import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.DealListWithPaging;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.ReplyVO;
import org.joongmae.domain.SellVO;
import org.joongmae.domain.WishAndSell;
import org.joongmae.domain.WishListVO;
import org.joongmae.domain.WishListWithPaging;
import org.joongmae.mapper.MypageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public int deleteBuy(int buyNo) {		
		return mapper.deleteBuy(buyNo);
	}
	
	@Override
	public BuyListWithPaging getBuyListWithPaging(Criteria cri) {		
		return new BuyListWithPaging(mapper.countBuy(cri), mapper.getBuyList(cri));
	}
	
	@Override
	public BuyListWithPaging dateSearchRange(Criteria cri) {
		log.info(cri);
		return new BuyListWithPaging(mapper.dateCntRange(cri), mapper.dateSearchRange(cri));
	}
	
	@Override
	public int buyCnt(String id) {		
		return mapper.buyCnt(id);
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
	
	@Transactional
	@Override
	public int deleteSell(int sellNo) {	
		mapper.deleteWishList(sellNo);
		return mapper.deleteSell(sellNo);
	}
	
	@Transactional
	@Override
	public int deleteAllSell() {
		mapper.deleteAllWish();
		return mapper.deleteAllSell();
	}
	
	@Override
	public int sellCnt(String id) {		
		return mapper.sellCnt(id);
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
	public int deleteDeal(int dealNo) {		
		return mapper.deleteDeal(dealNo);
	}	
	
	@Override
	public DealListWithPaging selectDeal(Criteria cri) {		
		return new DealListWithPaging(mapper.countSelectDeal(cri), mapper.selectDeal(cri));
	}
	
	@Override
	public DealListWithPaging getDealListWithPaging(Criteria cri) {	
		return new DealListWithPaging(mapper.countDeal(cri), mapper.getDealList(cri));
	}
	
	@Override
	public int completeCnt(Criteria cri) {		
		return mapper.completeCnt(cri);
	}

	@Override
	public int progressCnt(Criteria cri) {		
		return mapper.progressCnt(cri);
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
	
	@Transactional
	@Override
	public int deleteMember(String id) {
		mapper.deleteUser(id);
		
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
	public int deleteWish(List<String> checkArr) {	
		System.out.println(checkArr);
		 return mapper.deleteWish(checkArr);
	}
	
	@Override
	public int deleteAllWish() {		
		return mapper.deleteAllWish();
	}

	@Override
	public WishListWithPaging getWishListWithPaging(Criteria cri) {		
		return new WishListWithPaging(mapper.countWish(cri), mapper.getWishList(cri));
	}

	@Override
	public int replyInsert(ReplyVO reply) {		
		return mapper.replyInsert(reply);
	}

	@Override
	public List<ReplyVO> replyList(int dealNo) {		
		return mapper.replyList(dealNo);
	}

	@Override
	public int replyDelete(int replyNo) {		
		return mapper.replyDelete(replyNo);
	}
	
}
