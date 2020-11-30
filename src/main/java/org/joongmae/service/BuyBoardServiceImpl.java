package org.joongmae.service;

import java.util.ArrayList;
import java.util.List;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.BuyCriteria;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.SellVO;
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

	@Override
	public List<SellVO> sellList(String id) {
		
		return mapper.sellList(id);
	}

	@Override
	public boolean registerAlarm(AlarmVO vo) {
		
		return mapper.registerAlarm(vo) == 1;
	}

	@Override
	public SellVO sellDetail(int sellNo) {
		
		return mapper.sellDetail(sellNo);
	}

	public int registerAlarm(BuyVO buy) {
		 
		ArrayList<List<Object>> result = new ArrayList<>();
		
		List<SellVO> sellList = mapper.temp(buy.getId());
		
		String buyKeywords[] = new String[3];
		buyKeywords[0] = buy.getKeyword1();
		buyKeywords[1] = buy.getKeyword2();
		buyKeywords[2] = buy.getKeyword3();
		
		for (int index = 0; index < sellList.size(); index++) {
			
			String sellKeywords[] = new String[3];
			
			sellKeywords[0] = sellList.get(index).getKeyword1();
			sellKeywords[1] = sellList.get(index).getKeyword2();
			sellKeywords[2] = sellList.get(index).getKeyword3();
			
			for (int i = 0; i < 3; i++) {
				for (int j = i + 1; j < 3; j++) {
					if (sellKeywords[i].equals(sellKeywords[j])) {
						sellKeywords[j] = "";
					}
					if (buyKeywords[i].equals(buyKeywords[j])) {
						buyKeywords[j] = "";
					}
				}
			}
			
			for (int i = 0; i < 3; i++) {
				System.out.println("sellKeywords["+ i + "] : " + sellKeywords[i]);
			}
			
			for (int i = 0; i < 3; i++) {
				System.out.println("buyKeywords["+ i + "] : " + buyKeywords[i]);
			}
			
			int count = 0;
			
			for (int i = 0; i < 3; i++) {
				for (int j = 0; j < 3; j++) {
					if (sellKeywords[i].equals(buyKeywords[j])) {
						count++;
					}
				}
			}
			
			List<Object> list = new ArrayList<>();
			
			list.add(count);
			list.add(sellList.get(index).getId());
			list.add(sellList.get(index).getSellNo());
			
			result.add(list);
		}
		
		int point = 3;
		int count = 0;
		while(true){
			if (point == 0) {
				break;
			} else {
				for (int i = 0; i < result.size(); i++) {
					if (count == 10) {
						break;
					} else if (result.get(i).get(0).equals(point)) {
						AlarmVO alarm = new AlarmVO(0, buy.getId() , mapper.count(), (String)result.get(i).get(1), (Integer)result.get(i).get(2), "등록");
						System.out.println(alarm);
						mapper.registerAlarm(alarm);
						count++;
					}
				}
				point--;
			}
		}
		
		
		return 0;
	}

}
